import Foundation

@Observable final class UserAgreementViewModel {
    private(set) var agreementURL: URL?
    private(set) var screenState: ScreenState = .loading
    
    private let agreementURLString =
        "https://yandex.ru/legal/practicum_offer/"
    
    init() {
        guard let url = URL(string: agreementURLString) else {
            screenState = .error(.server)
            return
        }
        
        agreementURL = url
    }
    
    func didFinishLoading() {
        screenState = .content
    }
    
    func didFailLoading(_ error: Error) {
        if let urlError = error as? URLError,
           urlError.code == .notConnectedToInternet {
            screenState = .error(.noInternet)
        } else {
            screenState = .error(.server)
        }
    }
}
