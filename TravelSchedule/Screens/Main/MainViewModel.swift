import Foundation

@MainActor
@Observable
final class MainViewModel {
    var fromStation: Station?
    var toStation: Station?
    
    private(set) var screenState: ScreenState = .content
    
    func swapStations() {
        swap(&fromStation, &toStation)
    }
}
