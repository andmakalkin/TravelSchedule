import Foundation

struct City: Identifiable, Hashable, Sendable {
    let id = UUID()
    let name: String
    let stations: [Station]
}
