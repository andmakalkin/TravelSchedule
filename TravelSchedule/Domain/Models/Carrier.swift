import Foundation

struct Carrier: Identifiable, Hashable, Sendable {
    let code: Int
    let name: String
    let logoURL: URL?
    let email: String?
    let phone: String?
    
    var id: Int {
        code
    }
}
