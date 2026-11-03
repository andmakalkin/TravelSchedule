import Foundation

struct Station: Identifiable, Hashable, Sendable {
    let code: String
    let name: String
    let cityName: String
    
    var id: String {
        code
    }
    
    var displayName: String {
        if name.hasPrefix("\(cityName) ("),
           name.hasSuffix(")") {
            return name
        }
        
        return "\(cityName) (\(name))"
    }
}
