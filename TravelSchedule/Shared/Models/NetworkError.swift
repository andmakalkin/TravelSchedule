import Foundation

enum NetworkError: Error, Sendable {
    case noInternet
    case server
    
    static func map(_ error: Error) -> NetworkError {
        if let networkError = error as? NetworkError {
            return networkError
        }
        
        guard let urlError = error as? URLError else {
            return .server
        }
        
        switch urlError.code {
        case .notConnectedToInternet,
                .networkConnectionLost,
                .cannotFindHost,
                .cannotConnectToHost,
                .dnsLookupFailed:
            return .noInternet
            
        default:
            return .server
        }
    }
}
