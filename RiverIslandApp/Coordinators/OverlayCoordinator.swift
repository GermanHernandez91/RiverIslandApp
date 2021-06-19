import UIKit

final class OverlayCoordinator: Coordinator {
    
    // MARK: - Properties
    private var rootViewController: UIViewController?
    
    // MARK: - Methods
    func start() {
        // protocol requirement
    }
    
    func launch(_ screen: Screen, rootViewController: UIViewController?) {
        self.rootViewController = rootViewController
        DispatchQueue.main.async { [weak self] in self?.goTo(screen) }
    }
}

// MARK: - Data structures
extension OverlayCoordinator {
    
    enum Screen {
        case loading(Loader)
        case present(Dismissable, wrapInNav: Bool)
    }
}

// MARK: - Private implementation
private extension OverlayCoordinator {
    
    func goTo(_ screen: Screen) {
        
        guard let rootViewController = rootViewController else {
            #if DEBUG
                print("Calling OverlayCoordinator(\(screen) without a rootViewController")
            #endif
            return
        }
        
        switch screen {
        case let .loading(loader):
            
            guard loader.show else {
                dismiss(animated: false, shouldDelay: true)
                return
            }
            
            guard !isPresenting() else { return }
            
            let viewController = LoadingViewController()
            viewController.viewModelFactory = {
                LoadingViewModel(transparentStyle: loader.transparent, loadingMessage: loader.messages)
            }
            
            viewController.modalPresentationStyle = .overCurrentContext
            rootViewController.present(viewController, animated: false, completion: nil)
            
        case let .present(viewController, wrapInNav):
            
            guard !isPresenting() else { return }
            
            viewController.didTapDone = { [weak self] in self?.dismiss(animated: true) }
            
            if wrapInNav {
                let navigationController = UINavigationController(rootViewController: viewController)
                navigationController.modalPresentationStyle = .fullScreen
                rootViewController.present(viewController, animated: false, completion: nil)
            } else {
                rootViewController.present(viewController, animated: false, completion: nil)
            }
        }
    }
    
    func dismiss(animated: Bool, shouldDelay: Bool = false) {
        let delay = shouldDelay ? 0.5 : 0
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) { [weak self] in
            self?.rootViewController?.dismiss(animated: animated)
            self?.rootViewController = nil
        }
    }
    
    func isPresenting() -> Bool {
        if rootViewController?.presentedViewController == nil { return false }
        
        let description = String(describing: rootViewController?.presentedViewController)
        #if DEBUG
            print("Already presenting a view controller: \(description)")
        #endif
        
        return true
    }
}
