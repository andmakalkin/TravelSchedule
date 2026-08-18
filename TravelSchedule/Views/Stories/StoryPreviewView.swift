import SwiftUI

struct StoryPreviewView: View {
    let isViewed: Bool
    let story: Story
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Image(story.previewImage)
                .resizable()
                .scaledToFill()
            
            Text(story.title)
                .font(.system(size: 12, weight: .regular))
                .foregroundStyle(Color.ypWhiteLight)
                .tracking(0.4)
                .lineLimit(3)
                .padding(.horizontal, 8)
                .padding(.bottom, 12)
        }
        .frame(width: 92, height: 140)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .strokeBorder(.ypBlue, lineWidth: isViewed ? 0 : 4)
        )
        .opacity(isViewed ? 0.5 : 1)
    }
}

#Preview {
    StoryPreviewView(
        isViewed: true,
        story: MockData.stories[0]
    )
}

#Preview {
    StoryPreviewView(
        isViewed: false,
        story: MockData.stories[0]
    )
}
