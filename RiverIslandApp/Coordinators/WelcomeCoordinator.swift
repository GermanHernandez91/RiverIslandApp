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
        let networkSession: NetworkSession
        let commonActions: CommonActions
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
            let apiClient = APIClient(networkSession: dependencies.networkSession)
            let remoteDataSource = ProductsRemoteDataSource(apiClient: apiClient)
            let repository = ProductsRepo(remoteDataSource: remoteDataSource)
            let productsActions = ProductsCoordinator.Actions(displayEror: dependencies.commonActions.displayError,
                                                             displayLoader: dependencies.commonActions.displayLoader)
            let productsDependencies = ProductsCoordinator.Dependencies(navController: dependencies.navController,
                                                                        repository: repository,
                                                                        networkSession: dependencies.networkSession)
            let coordinator = ProductsCoordinator(dependencies: productsDependencies, actions: productsActions)
            
            childCoordinator = coordinator
            childCoordinator?.start()
        }
    }
}
