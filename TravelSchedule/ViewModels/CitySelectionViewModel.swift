import Foundation

@Observable final class CitySelectionViewModel {
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

    private(set) var cities: [City]
    private(set) var screenState: ScreenState = .content

    init(cities: [City] = MockData.cities) {
        self.cities = cities
    }
}
