import UIKit

private enum Screen {
    case fetchProducts
    case productsList(ProductsDto)
    case productItem(ProductItemDto)
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
        let networkSession: NetworkSession
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
            
            let viewController = ProductsListViewController()
            
            let repository = dependencies.repository
            
            viewController.viewModelFactory = {
                ProductsLListViewModel(data: products,
                                       repository: repository,
                                       didTapCell: { [weak self] in self?.goTo(.productItem($0)) })
            }
            
            dependencies.navController.setViewControllers([viewController], animated: false)
            
        case let.productItem(productItem):
            
            let viewController = ProductItemDetailsViewController()
            
            let repository = dependencies.repository
            
            viewController.viewModelFactory = {
                ProductItemDetailsViewModel(productItem: productItem, repository: repository)
            }
            
            dependencies.navController.present(viewController, animated: true)
        }
    }
}
