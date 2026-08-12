import Foundation

@Observable final class CarrierListViewModel {
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
                option.transferInfo == nil

            return matchesPeriod && matchesTransfers
        }
    }

    private(set) var selectedPeriods: Set<DeparturePeriod> = []
    private(set) var transfersOption: Bool?
    private(set) var screenState: ScreenState = .content

    private let travelOptions: [TravelOption]

    init(
        fromStation: Station,
        toStation: Station,
        travelOptions: [TravelOption] = MockData.travelOptions
    ) {
        self.fromStation = fromStation
        self.toStation = toStation
        self.travelOptions = travelOptions
    }

    func applyFilters(
        periods: Set<DeparturePeriod>,
        transfersOption: Bool?
    ) {
        selectedPeriods = periods
        self.transfersOption = transfersOption
    }
}
