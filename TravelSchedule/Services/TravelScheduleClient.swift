import Foundation

actor TravelScheduleClient {
    private let stationsListService: StationsListServiceProtocol
    private let scheduleBetweenStationsService: ScheduleBetweenStationsServiceProtocol
    
    private var cachedCities: [City]?
    private let schedulePageSize = 100
    
    init(
        stationsListService: StationsListServiceProtocol,
        scheduleBetweenStationsService: ScheduleBetweenStationsServiceProtocol
    ) {
        self.stationsListService = stationsListService
        self.scheduleBetweenStationsService = scheduleBetweenStationsService
    }
    
    func getCities() async throws -> [City] {
        if let cachedCities {
            return cachedCities
        }
        
        do {
            let response = try await stationsListService.getStationsList()
            
            var cities: [City] = []
            
            for country in response.countries {
                for region in country.regions {
                    for settlement in region.settlements {
                        let stations = settlement.stations.compactMap { station -> Station? in
                            guard let code = station.codes.yandex_code else {
                                return nil
                            }
                            
                            return Station(
                                code: code,
                                name: station.title,
                                cityName: settlement.title
                            )
                        }
                        
                        guard !stations.isEmpty else {
                            continue
                        }
                        
                        cities.append(
                            City(
                                name: settlement.title,
                                stations: stations
                            )
                        )
                    }
                }
            }
            
            cachedCities = cities
            
            return cities
            
        } catch is CancellationError {
            throw CancellationError()
        } catch {
            throw NetworkError.map(error)
        }
    }
    
    func getTravelOptions(
        from: String,
        to: String,
        date: String
    ) async throws -> [TravelOption] {
        do {
            let segments = try await getAllScheduleSegments(
                from: from,
                to: to,
                date: date
            )
            
            let travelOptions = segments.compactMap { segment in
                makeTravelOption(from: segment)
            }
            
            return travelOptions
            
        } catch is CancellationError {
            throw CancellationError()
        } catch {
            throw NetworkError.map(error)
        }
    }
    
    private func getSchedulePage(
        from: String,
        to: String,
        date: String,
        offset: Int
    ) async throws -> ScheduleBetweenStationsResponse {
        try await scheduleBetweenStationsService.getScheduleBetweenStations(
            from: from,
            to: to,
            date: date,
            transfers: true,
            offset: offset,
            limit: schedulePageSize
        )
    }
    
    private func getAllScheduleSegments(
        from: String,
        to: String,
        date: String
    ) async throws -> [Components.Schemas.Segment] {
        let firstPage = try await getSchedulePage(
            from: from,
            to: to,
            date: date,
            offset: 0
        )
        
        let total = firstPage.pagination.total
        
        guard total > schedulePageSize else {
            return firstPage.segments
        }
        
        let offsets = stride(
            from: schedulePageSize,
            to: total,
            by: schedulePageSize
        )
        
        let remainingSegments = try await withThrowingTaskGroup(
            of: (Int, [Components.Schemas.Segment]).self
        ) { group in
            for offset in offsets {
                group.addTask {
                    let page = try await self.getSchedulePage(
                        from: from,
                        to: to,
                        date: date,
                        offset: offset
                    )
                    
                    return (offset, page.segments)
                }
            }
            
            var pages: [(offset: Int, segments: [Components.Schemas.Segment])] = []
            
            for try await page in group {
                pages.append(page)
            }
            
            return pages
                .sorted { $0.offset < $1.offset }
                .flatMap(\.segments)
        }
        
        return firstPage.segments + remainingSegments
    }
    
    private func makeTravelOption(
        from segment: Components.Schemas.Segment
    ) -> TravelOption? {
        guard let departure = segment.departure,
              let arrival = segment.arrival,
              let hasTransfers = segment.has_transfers,
              let departureTime = formattedTime(from: departure),
              let arrivalTime = formattedTime(from: arrival),
              let departurePeriod = departurePeriod(
                from: departureTime
              ) else {
            return nil
        }
        
        let date: String?
        
        if let startDate = segment.start_date {
            date = formattedDate(from: startDate)
        } else {
            date = dateFromDateTime(departure)
        }
        
        let duration: String?
        
        if let segmentDuration = segment.duration {
            duration = formattedDuration(segmentDuration)
        } else if let calculatedDuration = calculatedDuration(
            from: departure,
            to: arrival
        ) {
            duration = formattedDuration(calculatedDuration)
        } else {
            duration = nil
        }
        
        guard let date,
              let duration else {
            return nil
        }
        
        let carrier = makeCarrier(
            from: segment.thread?.carrier?.value1
        )
        
        return TravelOption(
            carrier: carrier,
            date: date,
            departureTime: departureTime,
            arrivalTime: arrivalTime,
            duration: duration,
            hasTransfers: hasTransfers,
            departurePeriod: departurePeriod
        )
    }
    
    private func makeCarrier(
        from carrier: Components.Schemas.Carrier?
    ) -> Carrier? {
        guard let carrier,
              let code = carrier.code,
              let name = carrier.title else {
            return nil
        }
        
        return Carrier(
            code: code,
            name: name,
            logoURL: carrier.logo.flatMap(URL.init(string:)),
            email: carrier.email,
            phone: carrier.phone
        )
    }
    
    private func formattedDate(from dateString: String) -> String? {
        let inputFormatter = DateFormatter()
        inputFormatter.locale = Locale(identifier: "en_US_POSIX")
        inputFormatter.dateFormat = "yyyy-MM-dd"
        
        guard let date = inputFormatter.date(from: dateString) else {
            return nil
        }
        
        let outputFormatter = DateFormatter()
        outputFormatter.locale = Locale(identifier: "ru_RU")
        outputFormatter.dateFormat = "d MMMM"
        
        return outputFormatter.string(from: date)
    }
    
    private func formattedTime(from dateTimeString: String) -> String? {
        guard let timePart = dateTimeString.split(separator: "T").last else {
            return nil
        }
        
        let time = timePart.prefix(5)
        
        guard time.count == 5 else {
            return nil
        }
        
        return String(time)
    }
    
    private func dateFromDateTime(_ dateTimeString: String) -> String? {
        guard let datePart = dateTimeString.split(separator: "T").first else {
            return nil
        }
        
        return formattedDate(from: String(datePart))
    }
    
    private func departurePeriod(
        from time: String
    ) -> DeparturePeriod? {
        guard let hour = Int(time.prefix(2)) else {
            return nil
        }
        
        switch hour {
        case 0..<6:
            return .night
        case 6..<12:
            return .morning
        case 12..<18:
            return .day
        case 18..<24:
            return .evening
        default:
            return nil
        }
    }
    
    private func formattedDuration(_ duration: Double) -> String {
        let totalMinutes = Int(duration) / 60
        let hours = totalMinutes / 60
        let minutes = totalMinutes % 60
        
        var components: [String] = []
        
        if hours > 0 {
            components.append(
                "\(hours) \(hoursWord(for: hours))"
            )
        }
        
        if minutes > 0 {
            components.append(
                "\(minutes) \(minutesWord(for: minutes))"
            )
        }
        
        return components.joined(separator: " ")
    }
    
    private func calculatedDuration(
        from departure: String,
        to arrival: String
    ) -> Double? {
        let formatter = ISO8601DateFormatter()
        
        guard let departureDate = formatter.date(from: departure),
              let arrivalDate = formatter.date(from: arrival) else {
            return nil
        }
        
        return arrivalDate.timeIntervalSince(departureDate)
    }
    
    private func hoursWord(for value: Int) -> String {
        switch value % 100 {
        case 11...14:
            return "часов"
        default:
            switch value % 10 {
            case 1:
                return "час"
            case 2...4:
                return "часа"
            default:
                return "часов"
            }
        }
    }
    
    private func minutesWord(for value: Int) -> String {
        switch value % 100 {
        case 11...14:
            return "минут"
        default:
            switch value % 10 {
            case 1:
                return "минута"
            case 2...4:
                return "минуты"
            default:
                return "минут"
            }
        }
    }
}
