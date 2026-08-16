import SwiftUI

struct StoriesProgressBarView: View {
    let storiesCount: Int
    let currentIndex: Int
    let currentProgress: CGFloat
    
    var body: some View {
        HStack(spacing: 6) {
            ForEach(0..<storiesCount, id: \.self) { index in
                GeometryReader { geometry in
                    ZStack(alignment: .leading) {
                        Capsule()
                            .fill(Color.ypWhiteLight)
                        
                        Capsule()
                            .fill(Color.ypBlue)
                            .frame(
                                width: geometry.size.width * progress(for: index)
                            )
                    }
                }
            }
        }
        .frame(height: 6)
    }
    
    private func progress(for index: Int) -> CGFloat {
        switch index {
        case ..<currentIndex:
            return 1
        case currentIndex:
            return currentProgress
        default:
            return 0
        }
    }
}

#Preview {
    StoriesProgressBarView(
        storiesCount: 5,
        currentIndex: 3,
        currentProgress: 0.4
    )
}
