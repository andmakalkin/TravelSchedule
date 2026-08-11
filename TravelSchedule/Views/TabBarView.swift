import SwiftUI

struct TabBarView: View {
    var body: some View {
        TabView {
            NavigationStack {
                MainView()
            }
            .tabItem {
                Image(.tabBarSchedule)
                    .renderingMode(.template)
            }
            
            SettingsView()
                .tabItem {
                    Image(.tabBarSettings)
                        .renderingMode(.template)
                }
        }
    }
}

#Preview {
    TabBarView()
}
