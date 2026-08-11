import Foundation

@Observable final class StationSelectionViewModel {
    let city: City
    
    var searchText = ""
    
    var filteredStations: [Station] {
        let query = searchText.trimmingCharacters(
            in: .whitespacesAndNewlines
        )
        
        guard !query.isEmpty else {
            return city.stations
        }
        
        return city.stations.filter {
            $0.name.localizedCaseInsensitiveContains(query)
        }
    }
    
    private(set) var screenState: ScreenState = .content
    
    init(city: City) {
        self.city = city
    }
}
