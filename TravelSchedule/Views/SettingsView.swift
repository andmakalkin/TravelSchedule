import SwiftUI

struct SettingsView: View {
    var body: some View {
        ZStack {
            Color.ypWhite
                .ignoresSafeArea()
            
            Text("Настройки")
                .font(.system(size: 17, weight: .bold))
                .foregroundStyle(.ypBlack)
        }
    }
}

#Preview {
    SettingsView()
}
