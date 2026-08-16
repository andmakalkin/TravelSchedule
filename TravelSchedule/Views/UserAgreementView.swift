import SwiftUI

struct UserAgreementView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(AppSettings.self) private var appSettings
    
    @State private var viewModel = UserAgreementViewModel()

    var body: some View {
        ZStack {
            Color.ypWhite
                .ignoresSafeArea()
            
            if let url = viewModel.agreementURL {
                WebView(
                    url: url,
                    isDarkAppearance: appSettings.isDarkAppearance,
                    onLoadFinished: {
                        viewModel.didFinishLoading()
                    },
                    onLoadFailed: { error in
                        viewModel.didFailLoading(error)
                    }
                )
                .padding([.top, .leading, .trailing], 16)
                .ignoresSafeArea(.container, edges: .bottom)
            }
            
            switch viewModel.screenState {
            case .content:
                EmptyView()
                
            case .loading:
                ZStack {
                    Color.ypWhite
                        .ignoresSafeArea()
                    
                    ProgressView()
                }
                
            case .error(let errorState):
                ErrorView(errorState: errorState)
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundStyle(.ypBlack)
                }
            }
            
            ToolbarItem(placement: .principal) {
                Text("Пользовательское соглашение")
                    .font(.system(size: 17, weight: .bold))
                    .foregroundStyle(.ypBlack)
            }
        }
    }
}

#Preview {
    NavigationStack {
        UserAgreementView()
    }
    .environment(AppSettings())
}
