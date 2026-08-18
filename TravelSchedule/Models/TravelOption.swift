import Foundation

struct TravelOption: Identifiable, Hashable {
    let id = UUID()
    let carrier: Carrier
    let date: String
    let departureTime: String
    let arrivalTime: String
    let duration: String
    let transferInfo: String?
    let departurePeriod: DeparturePeriod
}
