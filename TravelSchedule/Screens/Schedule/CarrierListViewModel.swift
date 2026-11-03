import Foundation

@MainActor
@Observable
final class CarrierListViewModel {
    let fromStation: Station
    let toStation: Station
    
    // "Да" для вариантов с пересадками не делает фильтр активным,
    // так как не ограничивает исходный список.
    var hasActiveFilters: Bool {
        !selectedPeriods.isEmpty || transfersOption == false
    }

    var filteredTravelOptions: [TravelOption] {
        travelOptions.filter { option in
            let matchesPeriod =
                selectedPeriods.isEmpty ||
                selectedPeriods.contains(option.departurePeriod)

            let matchesTransfers =
                transfersOption != false ||
                !option.hasTransfers

            return matchesPeriod && matchesTransfers
        }
    }

    private(set) var selectedPeriods: Set<DeparturePeriod> = []
    private(set) var transfersOption: Bool?
    private(set) var screenState: ScreenState = .loading
    private(set) var travelOptions = [TravelOption]()
    
    private let travelScheduleClient: TravelScheduleClient
    private var hasLoaded = false
    
    private var tomorrowDate: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd"

        let tomorrow = Calendar.current.date(
            byAdding: .day,
            value: 1,
            to: Date()
        ) ?? Date()

        return formatter.string(from: tomorrow)
    }

    init(
        fromStation: Station,
        toStation: Station,
        travelScheduleClient: TravelScheduleClient
    ) {
        self.fromStation = fromStation
        self.toStation = toStation
        self.travelScheduleClient = travelScheduleClient
    }

    func loadTravelOptions() async {
        guard !hasLoaded else {
            return
        }
        
        screenState = .loading
        
        do {
            travelOptions = try await travelScheduleClient.getTravelOptions(
                from: fromStation.code,
                to: toStation.code,
                date: tomorrowDate
            )

            hasLoaded = true
            screenState = .content
            
        } catch NetworkError.noInternet {
            screenState = .error(.noInternet)
        } catch is CancellationError {
            return
        } catch {
            screenState = .error(.server)
        }
    }
    
    func applyFilters(
        periods: Set<DeparturePeriod>,
        transfersOption: Bool?
    ) {
        selectedPeriods = periods
        self.transfersOption = transfersOption
    }
}
