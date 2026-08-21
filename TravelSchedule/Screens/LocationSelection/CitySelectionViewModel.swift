import Foundation

@MainActor
@Observable
final class CitySelectionViewModel {
    var searchText = ""

    var filteredCities: [City] {
        let query = searchText.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        guard !query.isEmpty else {
            return cities
        }

        return cities.filter {
            $0.name.localizedCaseInsensitiveContains(query)
        }
    }

    private(set) var cities = [City]()
    private(set) var screenState: ScreenState = .loading
    
    private let travelScheduleClient: TravelScheduleClient

    init(travelScheduleClient: TravelScheduleClient) {
        self.travelScheduleClient = travelScheduleClient
    }
    
    func loadCities() async {
        do {
            cities = try await travelScheduleClient.getCities()
            screenState = .content
        } catch NetworkError.noInternet {
            screenState = .error(.noInternet)
        } catch is CancellationError {
            return
        } catch {
            screenState = .error(.server)
        }
    }
}
