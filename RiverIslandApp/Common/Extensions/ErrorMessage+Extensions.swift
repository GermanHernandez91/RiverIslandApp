import Foundation

enum ErrorScreenType {
    case fullScreen
    case modal
    case alert
}

extension ErrorMessage {
    
    static func noInternet(screenType: ErrorScreenType = .fullScreen) -> ErrorMessage {
        return .init(title: .noInternetTitle, actionTitle: .noInternetDesc, screenType: screenType)
    }
    
    static func somethingWentWrong(screenType: ErrorScreenType = .fullScreen) -> ErrorMessage {
        return .init(title: .somethingWentWrongTitle, actionTitle: .somethingWentWrongDesc, screenType: screenType)
    }
}

fileprivate extension String {
    
    // No internet
    static let noInternetTitle = "Please check your internet connection"
    static let noInternetDesc = "We cannot connect to our servers. Please check your internet connection and try again"
    
    // Something went wrong
    static let somethingWentWrongTitle = "Oh no!\nSomething went wrong!"
    static let somethingWentWrongDesc = "Please try again later"
}
