import SwiftUI

struct SettingsView: View {
    @Environment(AppSettings.self) private var appSettings
    
    @State private var isUserAgreementPresented = false
    
    var body: some View {
        @Bindable var appSettings = appSettings
        
        ZStack {
            Color.ypWhite
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                Toggle("Темная тема", isOn: $appSettings.isDarkAppearance)
                    .tint(.ypBlue)
                    .font(.system(size: 17, weight: .regular))
                    .foregroundStyle(.ypBlack)
                    .frame(
                        maxWidth: .infinity,
                        minHeight: 60
                    )
                
                Button {
                    isUserAgreementPresented = true
                } label: {
                    HStack {
                        Text("Пользовательское соглашение")
                            .font(.system(size: 17, weight: .regular))
                            .foregroundStyle(.ypBlack)
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .foregroundStyle(.ypBlack)
                            .font(.system(size: 17, weight: .semibold))
                    }
                    .frame(
                        maxWidth: .infinity,
                        minHeight: 60
                    )
                    .contentShape(Rectangle())
                }
                .buttonStyle(.plain)
                
                Spacer()
                
                VStack(spacing: 16) {
                    Text("Приложение использует API «Яндекс.Расписания»")
                    Text("Версия 1.0 (beta)")
                }
                .font(.system(size: 12, weight: .regular))
            }
            .padding([.leading, .trailing, .bottom], 16)
            .padding(.top, 24)
        }
        .fullScreenCover(
            isPresented: $isUserAgreementPresented
        ) {
            NavigationStack {
                UserAgreementView()
            }
        }
    }
}

#Preview {
    NavigationStack {
        SettingsView()
    }
    .environment(AppSettings())
}
