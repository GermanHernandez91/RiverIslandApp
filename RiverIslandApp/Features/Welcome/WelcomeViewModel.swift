import Foundation

struct WelcomeViewModel: WelcomeViewModelProtocol {
    
    // MARK: - Properties
    var title: String = .screenTitle
    
    private var actionBtnTapped: () -> Void
    
    // MARK: - Lifecycle
    init(actionBtnTapped: @escaping () -> Void) {
        self.actionBtnTapped = actionBtnTapped
    }
    
    // MARK: - Methods
    func didActionBtnTapped() {
        actionBtnTapped()
    }
}

fileprivate extension String {
    static let screenTitle = "River Island"
}
