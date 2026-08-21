import SwiftUI

struct StoriesPreviewView: View {
    let viewModel: StoriesPreviewViewModel
    let onStoryTapped: (Story) -> Void
    
    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack(spacing: 12) {
                ForEach(viewModel.stories) { story in
                    Button {
                        onStoryTapped(story)
                    } label: {
                        StoryPreviewView(
                            isViewed: viewModel.isViewed(story),
                            story: story
                        )
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.leading, 16)
        }
        .scrollIndicators(.hidden)
    }
}

#Preview {
    StoriesPreviewView(
        viewModel: StoriesPreviewViewModel(),
        onStoryTapped: { _ in }
    )
}
