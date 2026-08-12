import Foundation

struct TravelOption: Identifiable, Hashable {
    let id = UUID()
    let carrierName: String
    let carrierLogo: String
    let date: String
    let departureTime: String
    let arrivalTime: String
    let duration: String
    let transferInfo: String?
    let departurePeriod: DeparturePeriod
}
