import Foundation

struct WelcomeViewModel: WelcomeViewModelProtocol {
    
    // MARK: - Properties
    var title: String = .screenTitle
}

fileprivate extension String {
    static let screenTitle = "River Island"
}
