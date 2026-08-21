import Foundation

enum UserDefaultsKey: String {
    case isDarkAppearance
}

@Observable
final class AppSettings {
    var isDarkAppearance: Bool {
        didSet {
            UserDefaults.standard.set(
                isDarkAppearance,
                forKey: UserDefaultsKey.isDarkAppearance.rawValue
            )
        }
    }
    
    init() {
        isDarkAppearance = UserDefaults.standard.bool(
            forKey: UserDefaultsKey.isDarkAppearance.rawValue
        )
    }
}
