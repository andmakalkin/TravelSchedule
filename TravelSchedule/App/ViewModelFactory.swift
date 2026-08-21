import Foundation

@MainActor
final class ViewModelFactory {
    private let travelScheduleClient: TravelScheduleClient

    init(travelScheduleClient: TravelScheduleClient) {
        self.travelScheduleClient = travelScheduleClient
    }
    
    func makeCitySelectionViewModel() -> CitySelectionViewModel {
        CitySelectionViewModel(
            travelScheduleClient: travelScheduleClient
        )
    }
    
    func makeCarrierListViewModel(
        fromStation: Station,
        toStation: Station
    ) -> CarrierListViewModel {
        CarrierListViewModel(
            fromStation: fromStation,
            toStation: toStation,
            travelScheduleClient: travelScheduleClient
        )
    }
}
