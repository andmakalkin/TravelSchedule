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
                            .font(.system(size: 24, weight: .bold))
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
                                }
                            }
                            .padding(.horizontal, 16)
                            .padding(.top, 16)
                        }
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
                    Image(systemName: "chevron.left")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundStyle(.ypBlack)
                }
            }
            
            ToolbarItem(placement: .principal) {
                Text("Выбор станции")
                    .font(.system(size: 17, weight: .bold))
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
