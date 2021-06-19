import UIKit

final class ErrorHandlingCoordinator: Coordinator {
    
    // MARK: - Properties
    private let dependencies: Dependencies
    private let actions: Actions
    
    private lazy var viewControllerFactory = {
        ErrorViewControllerFactory(dependencies: .init(errorMessage: self.dependencies.errorMessage))
    }()
    
    // MARK: - Lifecycle
    init(dependencies: Dependencies, actions: Actions) {
        self.dependencies = dependencies
        self.actions = actions
    }
    
    // MARK: - Method
    func start() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.goTo(self.displayType(screenType: self.dependencies.errorMessage.screenType))
        }
    }
}

// MARK: - Data structures
extension ErrorHandlingCoordinator {
    
    enum Screen {
        case fullScreen
        case modal
        case alert
    }

    struct Actions {
        let dismissErrorView: () -> Void
        let common: CommonActions
    }
    
    struct Dependencies {
        let navController: UINavigationController
        let errorMessage: ErrorMessage
    }
}

// MARK: - Private implementation
private extension ErrorHandlingCoordinator {
    
    func displayType(screenType: ErrorScreenType) -> ErrorHandlingCoordinator.Screen {
        switch screenType {
        case .fullScreen:
            return Screen.fullScreen
        case .modal:
            return Screen.modal
        case .alert:
            return Screen.alert
        }
    }
    
    func goTo(_ screen: Screen) {
        
        switch screen {
        case .fullScreen:
            let viewController = viewControllerFactory.makeFullScreen(using: screen) { [weak self] in
                self?.completeAction()
            }
            
            dependencies.navController.pushViewController(viewController, animated: true)
            
        case .modal:
            let viewController = viewControllerFactory.makeFullScreen(using: screen) { [weak self] in
                self?.completeAction()
            }
            
            dependencies.navController.present(viewController, animated: true)
            
        case .alert:
            let alert = viewControllerFactory.makeAlert { [weak self] in
                self?.completeAction()
            }
            
            dependencies.navController.present(alert, animated: true)
        }
    }
    
    func completeAction() {
        actions.dismissErrorView()
    }
}
