import Foundation

@MainActor
@Observable
final class StoriesViewModel {
    let stories: [Story]
    
    var currentStory: Story {
        stories[currentIndex]
    }
    
    var hasNextStory: Bool {
        currentIndex < stories.count - 1
    }
    
    var hasPreviousStory: Bool {
        currentIndex > 0
    }
    
    private(set) var currentIndex: Int
    
    init(stories: [Story], initialStory: Story) {
        self.stories = stories
        self.currentIndex = stories.firstIndex(of: initialStory) ?? 0
    }
    
    func setCurrentIndex(_ index: Int) {
        guard stories.indices.contains(index) else { return }
        currentIndex = index
    }

    func showNextStory() {
        guard hasNextStory else { return }
        currentIndex += 1
    }
    
    func showPreviousStory() {
        guard hasPreviousStory else { return }
        currentIndex -= 1
    }
}
