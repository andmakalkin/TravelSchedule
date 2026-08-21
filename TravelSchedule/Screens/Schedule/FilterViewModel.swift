import Foundation

@MainActor
@Observable
final class FilterViewModel {
    var shouldShowApplyButton: Bool {
        hasActiveFilters || hasChanges
    }

    private(set) var selectedPeriods: Set<DeparturePeriod>
    private(set) var transfersOption: Bool?

    private let initialSelectedPeriods: Set<DeparturePeriod>
    private let initialTransfersOption: Bool?

    private var hasActiveFilters: Bool {
        !selectedPeriods.isEmpty || transfersOption != nil
    }

    private var hasChanges: Bool {
        selectedPeriods != initialSelectedPeriods ||
        transfersOption != initialTransfersOption
    }

    init(
        selectedPeriods: Set<DeparturePeriod>,
        transfersOption: Bool?
    ) {
        self.selectedPeriods = selectedPeriods
        self.transfersOption = transfersOption
        self.initialSelectedPeriods = selectedPeriods
        self.initialTransfersOption = transfersOption
    }

    func togglePeriod(_ period: DeparturePeriod) {
        if selectedPeriods.contains(period) {
            selectedPeriods.remove(period)
        } else {
            selectedPeriods.insert(period)
        }
    }

    func selectTransfersOption(_ value: Bool) {
        transfersOption = value
    }
}
