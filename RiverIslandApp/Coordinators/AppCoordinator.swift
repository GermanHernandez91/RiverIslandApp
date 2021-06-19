import UIKit

private enum Screen {
    case loader(Loader)
    case displayError(ErrorMessage)
    case onboarding
}

final class AppCoordinator: Coordinator {
    
    // MARK: - Properties
    private let dependencies: Dependencies
    private var childCoordinator: Coordinator?
    private var errorCoordinator: Coordinator?
    var rootViewController: UIViewController?
    
    private lazy var overlayCoordinator = OverlayCoordinator()
    lazy var commonActions: CommonActions = {
        return CommonActions(displayLoader: { [weak self] in self?.goTo(.loader($0)) },
                             displayError: { [weak self] in self?.goTo(.displayError($0)) })
    }()
    
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
    
    func reset() {
        childCoordinator = nil
    }
}

// MARK: - Data structures
extension AppCoordinator {
    
    struct Dependencies {
        let window: UIWindow
        let networkSession: NetworkSession
    }
}

// MARK: - Private implementation
private extension AppCoordinator {
    
    func goTo(_ screen: Screen) {
        
        switch screen {
        
        case let .loader(loader):
            overlayCoordinator.launch(.loading(loader), rootViewController: rootViewController)
            
        case let .displayError(errorMessage):
            
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                
                guard let navigationController = self.activeNavigationController else {
                    assertionFailure("Unable to retrive navigation controller")
                    return
                }
                
                let errorDependencies = ErrorHandlingCoordinator.Dependencies(navController: navigationController,
                                                                              errorMessage: errorMessage)
                
                let dismissError: () -> Void = { [weak self] in
                    self?.dismissErrorView(screenType: errorMessage.screenType)
                }
                
                let errorActions = ErrorHandlingCoordinator.Actions(dismissErrorView: dismissError,
                                                                    common: self.commonActions)
                
                self.errorCoordinator = ErrorHandlingCoordinator(dependencies: errorDependencies, actions: errorActions)
                self.errorCoordinator?.start()
            }
            
        case .onboarding:
            let navController = UINavigationController()
            rootViewController = navController
            let coordinator = makeWelcomeCoordinator(with: navController)
            childCoordinator = coordinator
            childCoordinator?.start()
        }
    }
    
    func dismissErrorView(screenType: ErrorScreenType) {
        
        switch screenType {
        case .fullScreen:
            activeNavigationController?.popToRootViewController(animated: false)
        case .modal:
            activeNavigationController?.dismiss(animated: true)
        case .alert:
            break
        }
        
        errorCoordinator = nil
    }
    
    var activeNavigationController: UINavigationController? {
        return rootViewController as? UINavigationController
    }
    
    func makeWelcomeCoordinator(with navController: UINavigationController) -> Coordinator {
        let welcomeDependencies = WelcomeCoordinator.Dependencies(navController: navController,
                                                                  networkSession: dependencies.networkSession,
                                                                  commonActions: commonActions)
        return WelcomeCoordinator(dependencies: welcomeDependencies)
    }
}
