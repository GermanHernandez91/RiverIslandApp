import UIKit

protocol ProductsListViewModelProtocol {
    var title: String { get }
}

final class ProductsListViewController: UIViewController {
    
    // MARK: - Properties
    private var viewModel: ProductsListViewModelProtocol!
    
    var viewModelFactory: () -> ProductsListViewModelProtocol = {
        fatalError("View model has not been created")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        
        bind(viewModel: viewModelFactory())
    }
}

// MARK: - Private implementation
private extension ProductsListViewController {
    
    func bind(viewModel: ProductsListViewModelProtocol) {
        self.viewModel = viewModel
        
        navigationItem.title = viewModel.title
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}
