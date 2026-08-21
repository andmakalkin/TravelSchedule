import SwiftUI

struct StationSelectionView: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var viewModel: StationSelectionViewModel
    
    private let onStationSelected: (Station) -> Void
    
    init(
        city: City,
        onStationSelected: @escaping (Station) -> Void
    ) {
        _viewModel = State(
            initialValue: StationSelectionViewModel(city: city)
        )
        self.onStationSelected = onStationSelected
    }
    
    var body: some View {
        ZStack {
            Color.ypWhite
                .ignoresSafeArea()
            
            switch viewModel.screenState {
            case .content:
                VStack(spacing: 0) {
                    SearchBarView(searchText: $viewModel.searchText)
                        .padding(.horizontal, 16)
                    
                    if viewModel.filteredStations.isEmpty {
                        Spacer()
                        
                        Text("Станция не найдена")
                            .font(.bold24)
                            .foregroundStyle(.ypBlack)
                        
                        Spacer()
                    } else {
                        ScrollView {
                            LazyVStack(spacing: 0) {
                                ForEach(viewModel.filteredStations) { station in
                                    Button {
                                        onStationSelected(station)
                                    } label: {
                                        HStack {
                                            Text(station.name)
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
                                }
                            }
                            .padding(.horizontal, 16)
                            .padding(.top, 16)
                        }
                        .scrollIndicators(.hidden)
                    }
                }
                
            case .loading:
                ProgressView()
                
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
                    Image(systemName: SystemImage.chevronLeft)
                        .font(.semibold17)
                        .foregroundStyle(.ypBlack)
                }
            }
            
            ToolbarItem(placement: .principal) {
                Text("Выбор станции")
                    .font(.bold17)
                    .foregroundStyle(.ypBlack)
            }
        }
    }
}

#Preview {
    NavigationStack {
        StationSelectionView(
            city: MockData.cities[0],
            onStationSelected: { _ in }
        )
    }
}
