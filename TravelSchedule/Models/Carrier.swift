import Foundation

struct Carrier: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let logo: String
    let email: String
    let phone: String
}
