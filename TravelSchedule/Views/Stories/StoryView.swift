import SwiftUI

struct StoryView: View {
    let story: Story
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottomLeading) {
                Image(story.largeImage)
                    .resizable()
                    .scaledToFill()
                    .frame(
                        width: geometry.size.width,
                        height: geometry.size.height
                    )
                    .clipped()
                
                VStack(spacing: 16) {
                    Text(story.title)
                        .font(.system(size: 34, weight: .bold))
                        .foregroundStyle(Color.ypWhiteLight)
                        .tracking(0.4)
                        .lineLimit(2)
                    
                    Text(story.description)
                        .font(.system(size: 20, weight: .regular))
                        .foregroundStyle(Color.ypWhiteLight)
                        .tracking(0.4)
                        .lineLimit(3)
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 40)
            }
            .frame(
                width: geometry.size.width,
                height: geometry.size.height
            )
            .clipShape(
                RoundedRectangle(cornerRadius: 40)
            )
        }
    }
}

#Preview {
    StoryView(story: MockData.stories[0])
}
