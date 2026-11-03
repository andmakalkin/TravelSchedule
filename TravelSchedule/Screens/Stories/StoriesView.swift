import SwiftUI
import Combine

struct StoriesView: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var viewModel: StoriesViewModel
    @State private var currentStoryProgress: CGFloat = 0
    @State private var storyStartDate = Date()
    
    private let onStoryViewed: (Story) -> Void
    
    private let dismissSwipeThreshold: CGFloat = 100
    private let storyDuration: TimeInterval = 10
    private let timer = Timer
        .publish(every: 0.05, on: .main, in: .common)
        .autoconnect()
    
    init(
        stories: [Story],
        initialStory: Story,
        onStoryViewed: @escaping (Story) -> Void
    ) {
        _viewModel = State(
            initialValue: StoriesViewModel(
                stories: stories,
                initialStory: initialStory
            )
        )
        self.onStoryViewed = onStoryViewed
    }
    
    var body: some View {
        ZStack {
            Color.ypBlackLight.ignoresSafeArea()
            
            TabView(
                selection: Binding(
                    get: {
                        viewModel.currentIndex
                    },
                    set: { index in
                        viewModel.setCurrentIndex(index)
                    }
                )
            ) {
                ForEach(viewModel.stories.indices, id: \.self) { index in
                    GeometryReader { geometry in
                        StoryView(story: viewModel.stories[index])
                            .simultaneousGesture(
                                SpatialTapGesture()
                                    .onEnded { value in
                                        handleTap(
                                            at: value.location,
                                            viewWidth: geometry.size.width
                                        )
                                    }
                            )
                    }
                    .tag(index)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            
            VStack(alignment: .trailing, spacing: 12) {
                StoriesProgressBarView(
                    storiesCount: viewModel.stories.count,
                    currentIndex: viewModel.currentIndex,
                    currentProgress: currentStoryProgress
                )
                
                Button {
                    dismiss()
                } label: {
                    Image(.icClose)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                }
                .buttonStyle(.plain)
                
                Spacer()
            }
            .padding(.top, 28)
            .padding(.horizontal, 12)
        }
        .onAppear {
            storyStartDate = Date()
            
            onStoryViewed(viewModel.currentStory)
        }
        .onChange(of: viewModel.currentIndex) {
            currentStoryProgress = 0
            storyStartDate = Date()
            
            onStoryViewed(viewModel.currentStory)
        }
        .onReceive(timer) { date in
            let elapsedTime = date.timeIntervalSince(storyStartDate)
            currentStoryProgress = min(elapsedTime / storyDuration, 1)
            
            if currentStoryProgress >= 1 {
                showNextStoryOrDismiss()
            }
        }
        .simultaneousGesture(
            DragGesture()
                .onEnded { value in
                    let isVerticalSwipe =
                        abs(value.translation.height) >
                        abs(value.translation.width)
                    
                    let isSwipeDown =
                        value.translation.height >
                        dismissSwipeThreshold
                    
                    if isVerticalSwipe && isSwipeDown {
                        dismiss()
                    }
                }
        )
    }
    
    private func showNextStoryOrDismiss() {
        if viewModel.hasNextStory {
            viewModel.showNextStory()
        } else {
            dismiss()
        }
    }
    
    private func handleTap(
        at location: CGPoint,
        viewWidth: CGFloat
    ) {
        if location.x < viewWidth / 2 {
            viewModel.showPreviousStory()
        } else {
            showNextStoryOrDismiss()
        }
    }
}

#Preview {
    StoriesView(
        stories: StoriesData.stories,
        initialStory: StoriesData.stories[0],
        onStoryViewed: { _ in }
    )
}
