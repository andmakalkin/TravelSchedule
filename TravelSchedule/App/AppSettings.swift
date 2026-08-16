import Foundation

@Observable final class AppSettings {
    var isDarkAppearance: Bool {
        didSet {
            UserDefaults.standard.set(
                isDarkAppearance,
                forKey: "isDarkAppearance"
            )
        }
    }
    
    init() {
        isDarkAppearance = UserDefaults.standard.bool(
            forKey: "isDarkAppearance"
        )
    }
}
