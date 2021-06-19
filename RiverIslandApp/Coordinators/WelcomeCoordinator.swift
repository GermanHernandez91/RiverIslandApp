import UIKit

private enum Screen {
    case welcome
}

final class WelcomeCoordinator: Coordinator {
    
    // MARK: - Properties
    private let dependencies: Dependencies
    
    // MARK: - Lifecylce
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    // MARK: - Methods
    func start() {
        goTo(.welcome)
    }
}

// MARK: - Data structures
extension WelcomeCoordinator {
    
    struct Dependencies {
        let navController: UINavigationController
    }
}

// MARK: - Private implementation
private extension WelcomeCoordinator {
    
    func goTo(_ screen: Screen) {
        
        switch screen {
        case .welcome:
            
            let viewController = WelcomeViewController()
            
            viewController.viewModelFactory = {
                WelcomeViewModel()
            }
            
            dependencies.navController.setViewControllers([viewController], animated: false)
        }
    }
}
