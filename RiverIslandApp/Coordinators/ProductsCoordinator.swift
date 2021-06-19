import UIKit

private enum Screen {
    case productsList
}

final class ProductsCoordinator: Coordinator {
    
    // MARK: - Properties
    private var childCoordinator: Coordinator?
    private let dependencies: Dependencies
    
    // MARK: - Lifeycle
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    // MARK: - Methods
    func start() {
        goTo(.productsList)
    }
}

// MARK: - Data structures
extension ProductsCoordinator {
    
    struct Dependencies {
        let navController: UINavigationController
    }
}

// MARK: - Private implementation
private extension ProductsCoordinator {
    
    func goTo(_ screen: Screen) {
        
        switch screen {
        case .productsList:
            
            let viewController = ProductsListViewController()
            
            viewController.viewModelFactory = {
                ProductsLListViewModel()
            }
            
            dependencies.navController.setViewControllers([viewController], animated: false)
        }
    }
}
