import SwiftUI

struct SettingsView: View {
    @Environment(AppSettings.self) private var appSettings
    
    @State private var viewModel = SettingsViewModel()
    
    var body: some View {
        @Bindable var appSettings = appSettings
        
        ZStack {
            Color.ypWhite
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                Toggle("Темная тема", isOn: $appSettings.isDarkAppearance)
                    .tint(.ypBlue)
                    .font(.regular17)
                    .foregroundStyle(.ypBlack)
                    .frame(
                        maxWidth: .infinity,
                        minHeight: 60
                    )
                
                Button {
                    viewModel.isUserAgreementPresented = true
                } label: {
                    HStack {
                        Text("Пользовательское соглашение")
                            .font(.regular17)
                            .foregroundStyle(.ypBlack)
                        
                        Spacer()
                        
                        Image(systemName: SystemImage.chevronRight)
                            .foregroundStyle(.ypBlack)
                            .font(.semibold17)
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
                .font(.regular12)
            }
            .padding([.leading, .trailing, .bottom], 16)
            .padding(.top, 24)
        }
        .fullScreenCover(
            isPresented: $viewModel.isUserAgreementPresented
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
