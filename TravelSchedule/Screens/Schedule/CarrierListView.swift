import SwiftUI

struct CarrierListView: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var viewModel: CarrierListViewModel
    
    init(viewModel: CarrierListViewModel) {
        _viewModel = State(initialValue: viewModel)
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Color.ypWhite
                .ignoresSafeArea()
            
            switch viewModel.screenState {
            case .content:
                VStack(spacing: 0) {
                    Text("\(viewModel.fromStation.displayName) → \(viewModel.toStation.displayName)")
                        .font(.bold24)
                        .foregroundStyle(.ypBlack)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 16)
                    
                    if viewModel.filteredTravelOptions.isEmpty {
                        VStack {
                            Spacer()
                            
                            Text("Вариантов нет")
                                .font(.bold24)
                                .foregroundStyle(.ypBlack)
                            
                            Spacer()
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .padding(.bottom, 84)
                    } else {
                        ScrollView {
                            LazyVStack(spacing: 8) {
                                ForEach(viewModel.filteredTravelOptions) { option in
                                    travelOptionRow(option)
                                }
                            }
                            .padding(.bottom, 92)
                        }
                        .scrollIndicators(.hidden)
                        .padding([.top, .horizontal], 16)
                    }
                }
                .padding(.top, 16)
                
                NavigationLink {
                    FilterView(
                        selectedPeriods: viewModel.selectedPeriods,
                        transfersOption: viewModel.transfersOption
                    ) { periods, transfersOption in
                        viewModel.applyFilters(
                            periods: periods,
                            transfersOption: transfersOption
                        )
                    }
                } label: {
                    HStack(spacing: 4) {
                        Text("Уточнить время")
                            .font(.bold17)
                        
                        if viewModel.hasActiveFilters {
                            Circle()
                                .fill(.ypRed)
                                .frame(width: 8, height: 8)
                        }
                    }
                    .foregroundStyle(Color.ypWhiteLight)
                    .frame(maxWidth: .infinity)
                    .frame(height: 60)
                    .background(.ypBlue)
                    .clipShape(
                        RoundedRectangle(cornerRadius: 16)
                    )
                }
                .buttonStyle(.plain)
                .padding(.horizontal, 16)
                .padding(.bottom, 24)
                
            case .loading:
                ProgressView()
                    .frame(
                        maxWidth: .infinity,
                        maxHeight: .infinity
                    )
                
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
        }
        .task {
            await viewModel.loadTravelOptions()
        }
    }
    
    private func carrierCard(_ option: TravelOption) -> some View {
        VStack(spacing: 18) {
            HStack(spacing: 8) {
                carrierLogo(option.carrier)
                
                HStack(alignment: .top, spacing: 0) {
                    VStack(alignment: .leading, spacing: 2) {
                        Text(option.carrier?.name ?? "—")
                            .font(.regular17)
                            .lineLimit(1)
                            .foregroundStyle(Color.ypBlackLight)
                        
                        if let transferInfo = option.transferInfo {
                            Text(transferInfo)
                                .font(.regular12)
                                .lineLimit(1)
                                .foregroundStyle(.ypRed)
                        }
                    }
                    
                    Spacer()
                    
                    Text(option.date)
                        .font(.regular12)
                        .tracking(0.4)
                        .foregroundStyle(Color.ypBlackLight)
                }
                .padding(.trailing, 7)
            }
            
            HStack(spacing: 4) {
                Text(option.departureTime)
                    .font(.regular17)
                    .foregroundStyle(Color.ypBlackLight)
                
                Rectangle()
                    .frame(height: 1)
                    .foregroundStyle(.ypGray)
                
                Text(option.duration)
                    .font(.regular12)
                    .tracking(0.4)
                    .fixedSize()
                    .foregroundStyle(Color.ypBlackLight)
                
                Rectangle()
                    .frame(height: 1)
                    .foregroundStyle(.ypGray)
                
                Text(option.arrivalTime)
                    .font(.regular17)
                    .foregroundStyle(Color.ypBlackLight)
            }
            .padding(.trailing, 14)
            
        }
        .padding([.leading, .vertical], 14)
        .frame(maxWidth: .infinity)
        .frame(height: 104)
        .background(Color.ypLightGrayLight)
        .clipShape(
            RoundedRectangle(cornerRadius: 24)
        )
        .contentShape(Rectangle())
    }
    
    private func carrierLogo(_ carrier: Carrier?) -> some View {
        AsyncImage(url: carrier?.logoURL) { image in
            image
                .resizable()
                .scaledToFit()
        } placeholder: {
            EmptyView()
        }
        .frame(width: 38, height: 38)
        .background(Color.ypWhiteLight)
        .clipShape(
            RoundedRectangle(cornerRadius: 12)
        )
    }
    
    @ViewBuilder
    private func travelOptionRow(_ option: TravelOption) -> some View {
        if let carrier = option.carrier {
            NavigationLink {
                CarrierView(carrier: carrier)
            } label: {
                carrierCard(option)
            }
            .buttonStyle(.plain)
        } else {
            carrierCard(option)
        }
    }
}
