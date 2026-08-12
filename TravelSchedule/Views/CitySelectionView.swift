import SwiftUI

struct CitySelectionView: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var viewModel = CitySelectionViewModel()
    
    let onStationSelected: (Station) -> Void
    
    var body: some View {
        ZStack {
            Color.ypWhite
                .ignoresSafeArea()
            
            switch viewModel.screenState {
            case .content:
                VStack(spacing: 0) {
                    SearchBarView(searchText: $viewModel.searchText)
                        .padding(.horizontal, 16)
                    
                    if viewModel.filteredCities.isEmpty {
                        Spacer()
                        
                        Text("Город не найден")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundStyle(.ypBlack)
                        
                        Spacer()
                    } else {
                        ScrollView {
                            LazyVStack(spacing: 0) {
                                ForEach(viewModel.filteredCities) { city in
                                    NavigationLink {
                                        StationSelectionView(
                                            city: city,
                                            onStationSelected: onStationSelected
                                        )
                                    } label: {
                                        HStack {
                                            Text(city.name)
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
                Text("Выбор города")
                    .font(.system(size: 17, weight: .bold))
                    .foregroundStyle(.ypBlack)
            }
        }
    }
}

#Preview {
    NavigationStack {
        CitySelectionView { _ in }
    }
}
