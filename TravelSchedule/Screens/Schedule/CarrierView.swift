import SwiftUI

struct CarrierView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.openURL) private var openURL
    
    @State private var viewModel: CarrierViewModel
    
    init(carrier: Carrier) {
        _viewModel = State(
            initialValue: CarrierViewModel(carrier: carrier)
        )
    }
    
    var body: some View {
        ZStack {
            Color.ypWhite
                .ignoresSafeArea()
            
            switch viewModel.screenState {
            case .content:
                VStack(alignment: .leading, spacing: 0) {
                    carrierLogo
                    
                    Text(viewModel.carrier.name)
                        .font(.bold24)
                        .foregroundStyle(.ypBlack)
                        .padding(.top, 16)
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Text("E-mail")
                            .font(.regular17)
                            .foregroundStyle(.ypBlack)
                        
                        if let email = viewModel.carrier.email,
                           !email.isEmpty,
                           let url = URL(string: "mailto:\(email)") {
                            Button {
                                openURL(url)
                            } label: {
                                Text(email)
                                    .font(.regular12)
                                    .tracking(0.4)
                                    .foregroundStyle(.ypBlue)
                            }
                        } else {
                            Text("Не указан")
                                .font(.regular12)
                                .tracking(0.4)
                                .foregroundStyle(.ypBlue)
                        }
                    }
                    .frame(height: 60)
                    .padding(.top, 16)
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Телефон")
                            .font(.regular17)
                            .foregroundStyle(.ypBlack)
                        
                        if let phone = viewModel.carrier.phone,
                           !phone.isEmpty,
                           let url = URL(string: "tel:\(formattedPhone(from: phone))") {
                            Button {
                                openURL(url)
                            } label: {
                                Text(phone)
                                    .font(.regular12)
                                    .tracking(0.4)
                                    .foregroundStyle(.ypBlue)
                            }
                        } else {
                            Text("Не указан")
                                .font(.regular12)
                                .tracking(0.4)
                                .foregroundStyle(.ypBlue)
                        }
                    }
                    .frame(height: 60)
                    
                    Spacer()
                }
                .padding([.top, .horizontal], 16)
                
            case .loading:
                ProgressView()
                
            case .error(let errorState):
                ErrorView(errorState: errorState)
            }
        }
        .toolbar(.hidden, for: .tabBar)
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: SystemImage.chevronLeft)
                        .font(.semibold17)
                        .foregroundStyle(.ypBlack)
                }
            }
            
            ToolbarItem(placement: .principal) {
                Text("Информация о перевозчике")
                    .font(.bold17)
                    .foregroundStyle(.ypBlack)
            }
        }
    }
    
    private var carrierLogo: some View {
        AsyncImage(url: viewModel.carrier.logoURL) { image in
            image
                .resizable()
                .scaledToFit()
        } placeholder: {
            EmptyView()
        }
        .frame(maxWidth: .infinity)
        .frame(height: 104)
        .background(Color.ypWhiteLight)
        .clipShape(
            RoundedRectangle(cornerRadius: 24)
        )
    }
    
    private func formattedPhone(from phone: String) -> String {
        let allowedCharacters = CharacterSet(charactersIn: "+0123456789")
        
        return phone
            .unicodeScalars
            .filter { allowedCharacters.contains($0) }
            .map { String($0) }
            .joined()
    }
}

#Preview {
    NavigationStack {
        CarrierView(carrier: MockData.rzd)
    }
}
