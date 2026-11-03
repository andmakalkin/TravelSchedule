enum StoriesData {
    static let stories: [Story] = (1...9).map { index in
        Story(
            title: text(count: 10),
            description: text(count: 30),
            largeImage: "story\(index)",
            previewImage: "story\(index)Preview"
        )
    }
    
    private static func text(count: Int) -> String {
        (0..<count)
            .map { _ in "Text" }
            .joined(separator: " ")
    }
}
