import UIKit

protocol ProductItemDetailsViewModelProtocol {
    var title: String { get }
    var product: ProductItemDto { get }
    var repository: ProductsRepository { get }
}

final class ProductItemDetailsViewController: UIViewController {
    
    // MARK: - Properties
    private let productImage = ProductImage(frame: .zero)
    private var viewModel: ProductItemDetailsViewModelProtocol!
    
    var viewModelFactory: () -> ProductItemDetailsViewModelProtocol = {
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
private extension ProductItemDetailsViewController {
    
    func bind(viewModel: ProductItemDetailsViewModelProtocol) {
        self.viewModel = viewModel
        
        navigationItem.title = viewModel.title
        configureProductImage()
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}

// MARK: - UI Components
private extension ProductItemDetailsViewController {
    
    func configureProductImage() {
        view.addSubview(productImage)
        
        productImage.downloadAvatarImage(fromURL: viewModel.product.image, repository: viewModel.repository)
        
        NSLayoutConstraint.activate([
            productImage.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            productImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            productImage.heightAnchor.constraint(equalToConstant: 300),
            productImage.widthAnchor.constraint(equalToConstant: 300)
        ])
    }
}
