import SwiftUI

struct CarrierView: View {
    @Environment(\.dismiss) private var dismiss
    
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
                    ZStack {
                        Color.ypWhiteLight
                        
                        Image(viewModel.carrier.logo)
                            .resizable()
                            .scaledToFit()
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 104)
                    .clipShape(
                        RoundedRectangle(cornerRadius: 24)
                    )
                    
                    Text(viewModel.carrier.name)
                        .font(.system(size: 24, weight: .bold))
                        .foregroundStyle(.ypBlack)
                        .padding(.top, 16)
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Text("E-mail")
                            .font(.system(size: 17, weight: .regular))
                            .foregroundStyle(.ypBlack)
                        
                        Text(viewModel.carrier.email)
                            .font(.system(size: 12, weight: .regular))
                            .tracking(0.4)
                            .foregroundStyle(.ypBlue)
                    }
                    .frame(height: 60)
                    .padding(.top, 16)
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Телефон")
                            .font(.system(size: 17, weight: .regular))
                            .foregroundStyle(.ypBlack)
                        
                        Text(viewModel.carrier.phone)
                            .font(.system(size: 12, weight: .regular))
                            .tracking(0.4)
                            .foregroundStyle(.ypBlue)
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
                    Image(systemName: "chevron.left")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundStyle(.ypBlack)
                }
            }
            
            ToolbarItem(placement: .principal) {
                Text("Информация о перевозчике")
                    .font(.system(size: 17, weight: .bold))
                    .foregroundStyle(.ypBlack)
            }
        }
    }
}

#Preview {
    NavigationStack {
        CarrierView(carrier: MockData.rzd)
    }
}
