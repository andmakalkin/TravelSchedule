import SwiftUI
import UIKit

extension Color {
    static let ypWhiteLight = Color(
        uiColor: UIColor(resource: .ypWhite)
            .resolvedColor(
                with: UITraitCollection(userInterfaceStyle: .light)
            )
    )
    
    static let ypBlackLight = Color(
        uiColor: UIColor(resource: .ypBlack)
            .resolvedColor(
                with: UITraitCollection(userInterfaceStyle: .light)
            )
    )
    
    static let ypLightGrayLight = Color(
        uiColor: UIColor(resource: .ypLightGray)
            .resolvedColor(
                with: UITraitCollection(userInterfaceStyle: .light)
            )
    )
}
