import SwiftUI

struct CarrierListView: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var viewModel: CarrierListViewModel
    
    init(fromStation: Station, toStation: Station) {
        _viewModel = State(
            initialValue: CarrierListViewModel(
                fromStation: fromStation,
                toStation: toStation
            )
        )
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Color.ypWhite
                .ignoresSafeArea()
            
            switch viewModel.screenState {
            case .content:
                VStack(spacing: 0) {
                    Text("\(viewModel.fromStation.displayName) → \(viewModel.toStation.displayName)")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundStyle(.ypBlack)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 16)
                    
                    if viewModel.filteredTravelOptions.isEmpty {
                        VStack {
                            Spacer()
                            
                            Text("Вариантов нет")
                                .font(.system(size: 24, weight: .bold))
                                .foregroundStyle(.ypBlack)
                            
                            Spacer()
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .padding(.bottom, 84)
                    } else {
                        ScrollView {
                            LazyVStack(spacing: 8) {
                                ForEach(viewModel.filteredTravelOptions) { option in
                                    NavigationLink {
                                        CarrierView(carrier: option.carrier)
                                    } label: {
                                        carrierCard(option)
                                    }
                                    .buttonStyle(.plain)
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
                            .font(.system(size: 17, weight: .bold))
                        
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
        }
    }
    
    private func carrierCard(_ option: TravelOption) -> some View {
        VStack(spacing: 18) {
            HStack(spacing: 8) {
                Image(option.carrier.logo)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 38, height: 38)
                    .clipShape(
                        RoundedRectangle(cornerRadius: 12)
                    )
                
                HStack(alignment: .top, spacing: 0) {
                    VStack(alignment: .leading, spacing: 2) {
                        Text(option.carrier.name)
                            .font(.system(size: 17, weight: .regular))
                            .lineLimit(1)
                            .foregroundStyle(Color.ypBlackLight)
                        
                        if let transferInfo = option.transferInfo {
                            Text(transferInfo)
                                .font(.system(size: 12, weight: .regular))
                                .lineLimit(1)
                                .foregroundStyle(.ypRed)
                        }
                    }
                    
                    Spacer()
                    
                    Text(option.date)
                        .font(.system(size: 12, weight: .regular))
                        .tracking(0.4)
                        .foregroundStyle(Color.ypBlackLight)
                }
                .padding(.trailing, 7)
            }
            
            HStack(spacing: 4) {
                Text(option.departureTime)
                    .font(.system(size: 17, weight: .regular))
                    .foregroundStyle(Color.ypBlackLight)
                
                Rectangle()
                    .frame(height: 1)
                    .foregroundStyle(.ypGray)
                
                Text(option.duration)
                    .font(.system(size: 12, weight: .regular))
                    .tracking(0.4)
                    .foregroundStyle(Color.ypBlackLight)
                
                Rectangle()
                    .frame(height: 1)
                    .foregroundStyle(.ypGray)
                
                Text(option.arrivalTime)
                    .font(.system(size: 17, weight: .regular))
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
}

#Preview {
    NavigationStack {
        CarrierListView(
            fromStation: Station(
                name: "Курский вокзал",
                cityName: "Москва"
            ),
            toStation: Station(
                name: "Балтийский вокзал",
                cityName: "Санкт-Петербург"
            )
        )
    }
}
