import SwiftUI

struct SearchBarView: View {
    @Binding var searchText: String
    
    @FocusState private var isFocused: Bool
    
    let placeholder = "Введите запрос"
    
    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: SystemImage.magnifyingGlass)
                .font(.regular17)
                .foregroundStyle(.ypGray)
            
            TextField(
                "",
                text: $searchText,
                prompt: Text(placeholder)
                    .foregroundStyle(.ypGray)
            )
            .font(.regular17)
            .foregroundStyle(.ypBlack)
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled()
            .submitLabel(.search)
            .focused($isFocused)
            
            if !searchText.isEmpty {
                Button {
                    searchText = ""
                } label: {
                    Image(systemName: SystemImage.xmarkCircleFill)
                        .font(.regular17)
                        .foregroundStyle(.ypGray)
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.horizontal, 8)
        .frame(height: 36)
        .background(.ypLightGray)
        .clipShape(
            RoundedRectangle(cornerRadius: 10)
        )
        .contentShape(Rectangle())
        .onTapGesture {
            isFocused = true
        }
    }
}

#Preview {
    SearchBarView(
        searchText: .constant("")
    )
    .padding()
}
