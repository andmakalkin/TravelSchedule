import Foundation

struct Story: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let description: String
    let largeImage: String
    let previewImage: String
}
