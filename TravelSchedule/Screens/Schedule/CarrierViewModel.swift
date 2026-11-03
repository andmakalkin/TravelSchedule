import Foundation

@MainActor
@Observable
final class CarrierViewModel {
    let carrier: Carrier
    
    private(set) var screenState: ScreenState = .content
    
    init(carrier: Carrier) {
        self.carrier = carrier
    }
}
