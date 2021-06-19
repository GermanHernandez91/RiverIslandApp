import UIKit

protocol ProductsListViewModelProtocol {
    var title: String { get }
    var rowSize: CGFloat { get }
    var products: [ProductItemDto] { get }
    var repository: ProductsRepository { get }
    
    func navigateToProductDetails(with productItem: ProductItemDto)
}

final class ProductsListViewController: UIViewController {
    
    // MARK: - Properties
    private let tableView = UITableView()
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
        configureTableView()
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        
        tableView.frame = view.bounds
        tableView.rowHeight = viewModel.rowSize
        tableView.delegate = self
        tableView.dataSource = self
        tableView.removeExcessCells()
        
        tableView.reloadData()
        tableView.register(ProductCell.self, forCellReuseIdentifier: ProductCell.reuseId)
    }
}

// MARK: - UITableView extension
extension ProductsListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: ProductCell.reuseId, for: indexPath) as? ProductCell {
            cell.set(product: viewModel.products[indexPath.row], repository: viewModel.repository)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let product = viewModel.products[indexPath.row]
        viewModel.navigateToProductDetails(with: product)
    }
}
