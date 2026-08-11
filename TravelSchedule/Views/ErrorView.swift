import SwiftUI

struct ErrorView: View {
    let errorState: ErrorState
    
    var body: some View {
        ZStack {
            Color.ypWhite
                .ignoresSafeArea()
            
            VStack(spacing: 16) {
                Image(
                    errorState == .server
                    ? .serverError
                    : .noInternet
                )
                .resizable()
                .scaledToFill()
                .frame(width: 223, height: 223)
                
                Text(
                    errorState == .server
                    ? "Ошибка сервера"
                    : "Нет интернета"
                )
                .font(.system(size: 24, weight: .bold))
                .foregroundStyle(.ypBlack)
            }
        }
    }
}

#Preview("Ошибка сервера") {
    ErrorView(errorState: .server)
}

#Preview("Нет интернета") {
    ErrorView(errorState: .noInternet)
}
