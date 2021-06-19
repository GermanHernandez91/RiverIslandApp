import UIKit

private enum Screen {
    case welcome
    case products
}

final class WelcomeCoordinator: Coordinator {
    
    // MARK: - Properties
    private var childCoordinator: Coordinator?
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
                WelcomeViewModel(actionBtnTapped: { [weak self] in
                    guard let self = self else { return }
                    self.goTo(.products)
                })
            }
            
            dependencies.navController.setViewControllers([viewController], animated: false)
            
        case .products:
            let coordinator = makeProductsCoordinator(with: dependencies.navController)
            childCoordinator = coordinator
            childCoordinator?.start()
        }
    }
    
    func makeProductsCoordinator(with navController: UINavigationController) -> Coordinator {
        let productsDependencies = ProductsCoordinator.Dependencies(navController: navController)
        return ProductsCoordinator(dependencies: productsDependencies)
    }
}
