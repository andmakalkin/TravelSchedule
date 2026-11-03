import Foundation

struct TravelOption: Identifiable, Hashable, Sendable {
    let id = UUID()
    let carrier: Carrier?
    let date: String
    let departureTime: String
    let arrivalTime: String
    let duration: String
    let hasTransfers: Bool
    let departurePeriod: DeparturePeriod

    var transferInfo: String? {
        hasTransfers ? "С пересадкой" : nil
    }
}
