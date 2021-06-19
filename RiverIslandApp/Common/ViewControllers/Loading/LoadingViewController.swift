import UIKit

protocol LoadingViewModelProtocol {
    var transparentStyle: Bool { get }
    var loadingMessage: [String] { get }
}

final class LoadingViewController: UIViewController {
    
    // MARK: - Properties
    private var containerView: UIView!
    private var viewModel: LoadingViewModelProtocol!
    
    var viewModelFactory: () -> LoadingViewModelProtocol = {
        fatalError("View model has not been created")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        bind(viewModel: viewModelFactory())
    }
}

// MARK: - Private implementation
private extension LoadingViewController {
    
    func bind(viewModel: LoadingViewModelProtocol) {
        self.viewModel = viewModel
        
        if viewModel.transparentStyle {
            view.backgroundColor = UIColor.systemBackground.withAlphaComponent(0.6)
        } else {
            view.backgroundColor = .systemBackground
        }
    }
    
    func setupUI() {
        
        var activityIndicator: UIActivityIndicatorView!
        activityIndicator = UIActivityIndicatorView(style: .large)
        
        view.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        
        activityIndicator.startAnimating()
    }
}
