import Foundation

struct Station: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let cityName: String

    var displayName: String {
        "\(cityName) (\(name))"
    }
}
