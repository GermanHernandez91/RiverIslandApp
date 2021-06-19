import UIKit

private enum Screen {
    case fetchProducts
    case productsList(ProductsDto)
}

final class ProductsCoordinator: Coordinator {
    
    // MARK: - Properties
    private var childCoordinator: Coordinator?
    private let dependencies: Dependencies
    private let actions: Actions
    
    // MARK: - Lifeycle
    init(dependencies: Dependencies, actions: Actions) {
        self.dependencies = dependencies
        self.actions = actions
    }
    
    // MARK: - Methods
    func start() {
        goTo(.fetchProducts)
    }
}

// MARK: - Data structures
extension ProductsCoordinator {
    
    struct Actions {
        let displayEror: DisplayError
        let displayLoader: DisplayLoader
    }
    
    struct Dependencies {
        let navController: UINavigationController
        let repository: ProductsRepository
    }
}

// MARK: - Private implementation
private extension ProductsCoordinator {
    
    func goTo(_ screen: Screen) {
        
        switch screen {
        case .fetchProducts:
            actions.displayLoader(.init(show: true))
            
            dependencies.repository.fetchProducts { [weak self] result in
                guard let self = self else { return }
                
                self.actions.displayLoader(.init(show: false))
                
                switch result {
                case .success(let products):
                    self.goTo(.productsList(products))
                    
                case .failure(let error):
                    debugPrint(error.localizedDescription)
                    self.actions.displayEror(.somethingWentWrong())
                }
            }
            
            
        case let .productsList(products):
            
            print(products)
            
            let viewController = ProductsListViewController()
            
            viewController.viewModelFactory = {
                ProductsLListViewModel()
            }
            
            dependencies.navController.setViewControllers([viewController], animated: false)
        }
    }
}
