import Foundation

@Observable final class StoriesPreviewViewModel {
    let stories: [Story]
    
    private var viewedStoryIDs: Set<UUID> = []
    
    init(stories: [Story] = MockData.stories) {
        self.stories = stories
    }
    
    func isViewed(_ story: Story) -> Bool {
        viewedStoryIDs.contains(story.id)
    }
    
    func markAsViewed(_ story: Story) {
        viewedStoryIDs.insert(story.id)
    }
}
