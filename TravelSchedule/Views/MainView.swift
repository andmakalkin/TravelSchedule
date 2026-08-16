import SwiftUI

struct MainView: View {
    private enum StationSelectionType: Hashable, Identifiable {
        case from
        case to
        
        var id: Self {
            self
        }
    }
    
    @State private var viewModel = MainViewModel()
    @State private var storiesPreviewViewModel = StoriesPreviewViewModel()
    
    @State private var selectedStory: Story?
    @State private var stationSelectionType: StationSelectionType?
    
    var body: some View {
        ZStack {
            Color.ypWhite
                .ignoresSafeArea()
            
            switch viewModel.screenState {
            case .content:
                ScrollView {
                    VStack(spacing: 0) {
                        StoriesPreviewView(
                            viewModel: storiesPreviewViewModel
                        ) { story in
                            selectedStory = story
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 188)
                        .padding(.bottom, 20)
                        
                        HStack(spacing: 16) {
                            VStack(alignment: .leading, spacing: 0) {
                                Button {
                                    stationSelectionType = .from
                                } label: {
                                    Text(viewModel.fromStation?.displayName ?? "Откуда")
                                        .foregroundStyle(
                                            viewModel.fromStation == nil
                                            ? Color.ypGray
                                            : Color.ypBlackLight
                                        )
                                        .padding(.horizontal, 16)
                                        .frame(
                                            maxWidth: .infinity,
                                            maxHeight: .infinity,
                                            alignment: .leading
                                        )
                                        .contentShape(Rectangle())
                                }
                                .buttonStyle(.plain)
                                
                                Button {
                                    stationSelectionType = .to
                                } label: {
                                    Text(viewModel.toStation?.displayName ?? "Куда")
                                        .foregroundStyle(
                                            viewModel.toStation == nil
                                            ? Color.ypGray
                                            : Color.ypBlackLight
                                        )
                                        .padding(.horizontal, 16)
                                        .frame(
                                            maxWidth: .infinity,
                                            maxHeight: .infinity,
                                            alignment: .leading
                                        )
                                        .contentShape(Rectangle())
                                }
                                .buttonStyle(.plain)
                            }
                            .font(.system(size: 17, weight: .regular))
                            .lineLimit(1)
                            .frame(
                                maxWidth: .infinity,
                                maxHeight: .infinity,
                                alignment: .leading
                            )
                            .background(Color.ypWhiteLight)
                            .clipShape(
                                RoundedRectangle(cornerRadius: 20)
                            )
                            
                            Button {
                                viewModel.swapStations()
                            } label: {
                                Image(.icChange)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 36, height: 36)
                            }
                            .buttonStyle(.plain)
                            
                        }
                        .padding(16)
                        .frame(maxWidth: .infinity)
                        .frame(height: 128)
                        .background(.ypBlue)
                        .clipShape(
                            RoundedRectangle(cornerRadius: 20)
                        )
                        .padding(.horizontal, 16)
                        
                        if let fromStation = viewModel.fromStation,
                           let toStation = viewModel.toStation {
                            NavigationLink {
                                CarrierListView(
                                    fromStation: fromStation,
                                    toStation: toStation
                                )
                            } label: {
                                Text("Найти")
                                    .font(.system(size: 17, weight: .bold))
                                    .foregroundStyle(Color.ypWhiteLight)
                                    .frame(width: 150, height: 60)
                                    .background(.ypBlue)
                                    .clipShape(
                                        RoundedRectangle(cornerRadius: 16)
                                    )
                            }
                            .padding(16)
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
                .scrollIndicators(.hidden)
                
            case .loading:
                ProgressView()
                
            case .error(let errorState):
                ErrorView(errorState: errorState)
            }
        }
        .fullScreenCover(item: $stationSelectionType) { selectionType in
            NavigationStack {
                CitySelectionView { station in
                    switch selectionType {
                    case .from:
                        viewModel.fromStation = station
                        
                    case .to:
                        viewModel.toStation = station
                    }
                    
                    stationSelectionType = nil
                }
            }
        }
        .fullScreenCover(item: $selectedStory) { story in
            StoriesView(
                stories: storiesPreviewViewModel.stories,
                initialStory: story
            ) { viewedStory in
                storiesPreviewViewModel.markAsViewed(viewedStory)
            }
        }
    }
}

#Preview {
    TabBarView()
}
