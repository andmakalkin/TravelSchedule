import SwiftUI
import OpenAPIURLSession

@main
struct TravelScheduleApp: App {
    @State private var appSettings = AppSettings()
    private let appDependencies: AppDependencies?
    
    @MainActor
    init() {
        do {
            let client = Client(
                serverURL: try Servers.Server1.url(),
                transport: URLSessionTransport(),
                middlewares: [APIKeyMiddleware()]
            )

            let stationsListService = StationsListService(
                client: client
            )

            let scheduleBetweenStationsService = ScheduleBetweenStationsService(
                client: client
            )
            
            let travelScheduleClient = TravelScheduleClient(
                stationsListService: stationsListService,
                scheduleBetweenStationsService: scheduleBetweenStationsService
            )

            let viewModelFactory = ViewModelFactory(
                travelScheduleClient: travelScheduleClient
            )

            appDependencies = AppDependencies(
                viewModelFactory: viewModelFactory
            )
        } catch {
            appDependencies = nil

            print("❌ [TravelScheduleApp] Ошибка создания зависимостей: \(error)")
        }
        
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
            if let appDependencies {
                TabBarView()
                    .environment(appDependencies)
                    .environment(appSettings)
                    .preferredColorScheme(
                        appSettings.isDarkAppearance
                        ? .dark
                        : .light
                    )
            } else {
                ErrorView(errorState: .server)
                    .environment(appSettings)
                    .preferredColorScheme(
                        appSettings.isDarkAppearance
                        ? .dark
                        : .light
                    )
            }
        }
    }
}

#Preview {
    TabBarView()
}
