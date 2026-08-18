import SwiftUI

@main
struct TravelScheduleApp: App {
    @State private var appSettings = AppSettings()
    
    @MainActor
    init() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        
        appearance.backgroundColor = .ypWhite
        appearance.shadowColor = .separator
        
        let itemAppearance = appearance.stackedLayoutAppearance
        itemAppearance.selected.iconColor = .ypBlack
        itemAppearance.normal.iconColor = .ypGray
        
        let tabBar = UITabBar.appearance()
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
    }
    
    var body: some Scene {
        WindowGroup {
            TabBarView()
                .environment(appSettings)
                .preferredColorScheme(
                    appSettings.isDarkAppearance
                    ? .dark
                    : .light
                )
        }
    }
}

#Preview {
    TabBarView()
}
