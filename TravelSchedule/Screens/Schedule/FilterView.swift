import SwiftUI

struct FilterView: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var viewModel: FilterViewModel

    private let onApply: (Set<DeparturePeriod>, Bool?) -> Void
    
    init(
        selectedPeriods: Set<DeparturePeriod>,
        transfersOption: Bool?,
        onApply: @escaping (Set<DeparturePeriod>, Bool?) -> Void
    ) {
        _viewModel = State(
            initialValue: FilterViewModel(
                selectedPeriods: selectedPeriods,
                transfersOption: transfersOption
            )
        )

        self.onApply = onApply
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Color.ypWhite
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 16) {
                    Text("Время отправления")
                        .font(.bold24)
                        .foregroundStyle(.ypBlack)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    VStack(spacing: 0) {
                        ForEach(DeparturePeriod.allCases, id: \.self) { period in
                            periodRow(period)
                        }
                    }
                    
                    Text("Показывать варианты с пересадками")
                        .font(.bold24)
                        .foregroundStyle(.ypBlack)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    VStack(spacing: 0) {
                        transferOptionRow(
                            title: "Да",
                            value: true
                        )
                        
                        transferOptionRow(
                            title: "Нет",
                            value: false
                        )
                    }
                }
                .padding(.horizontal, 16)
                .padding(.top, 16)
                .padding(.bottom, 92)
            }
            .scrollIndicators(.hidden)
            
            if viewModel.shouldShowApplyButton {
                Button {
                    onApply(
                        viewModel.selectedPeriods,
                        viewModel.transfersOption
                    )
                    
                    dismiss()
                } label: {
                    Text("Применить")
                        .font(.bold17)
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
    }
    
    private func periodRow(_ period: DeparturePeriod) -> some View {
        Button {
            viewModel.togglePeriod(period)
        } label: {
            HStack {
                Text(period.rawValue)
                    .font(.regular17)
                    .foregroundStyle(.ypBlack)
                
                Spacer()
                
                Image(
                    systemName: viewModel.selectedPeriods.contains(period)
                    ? SystemImage.checkmarkSquareFill
                    : SystemImage.square
                )
                .font(.regular24)
                .foregroundStyle(.ypBlack)
            }
            .frame(height: 60)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
    
    private func transferOptionRow(title: String, value: Bool) -> some View {
        Button {
            viewModel.selectTransfersOption(value)
        } label: {
            HStack {
                Text(title)
                    .font(.regular17)
                    .foregroundStyle(.ypBlack)
                
                Spacer()
                
                ZStack {
                    Circle()
                        .stroke(.ypBlack, lineWidth: 2)
                        .frame(width: 20, height: 20)
                    
                    if viewModel.transfersOption == value {
                        Circle()
                            .fill(.ypBlack)
                            .frame(width: 10, height: 10)
                    }
                }
                .frame(width: 24, height: 24)
            }
            .frame(height: 60)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    NavigationStack {
        FilterView(
            selectedPeriods: [],
            transfersOption: nil
        ) { _, _ in }
    }
}
