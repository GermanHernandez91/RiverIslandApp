import UIKit

private enum Screen {
    case onboarding
}

final class AppCoordinator: Coordinator {
    
    // MARK: - Properties
    private let dependencies: Dependencies
    private var childCoordinator: Coordinator?
    var rootViewController: UIViewController?
    
    // MARK: - Lifecycle
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    // MARK: - Methods
    func start() {
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            self.goTo(.onboarding)
            self.dependencies.window.rootViewController = self.rootViewController
            self.dependencies.window.makeKeyAndVisible()
        }
    }
}

// MARK: - Data structures
extension AppCoordinator {
    
    struct Dependencies {
        let window: UIWindow
    }
}

// MARK: - Private implementation
private extension AppCoordinator {
    
    func goTo(_ screen: Screen) {
        
        switch screen {
        case .onboarding:
            let navController = UINavigationController()
            rootViewController = navController
            let coordinator = makeWelcomeCoordinator(with: navController)
            childCoordinator = coordinator
            childCoordinator?.start()
        }
    }
    
    func makeWelcomeCoordinator(with navController: UINavigationController) -> Coordinator {
        let welcomeDependencies = WelcomeCoordinator.Dependencies(navController: navController)
        return WelcomeCoordinator(dependencies: welcomeDependencies)
    }
}
