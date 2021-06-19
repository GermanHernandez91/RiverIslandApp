import UIKit

struct ProductsLListViewModel: ProductsListViewModelProtocol {
    
    // MARK: - Properties
    var title: String = .screenTitle
    var rowSize: CGFloat = 120
    var products: [ProductItemDto] = []
    var repository: ProductsRepository
    
    private var didTapCell: (ProductItemDto) -> Void
    
    // MARK: - Lifecycle
    init(data: ProductsDto, repository: ProductsRepository, didTapCell: @escaping (ProductItemDto) -> Void) {
        self.products = data.products
        self.repository = repository
        self.didTapCell = didTapCell
    }
    
    // MARK: - Methods
    func navigateToProductDetails(with productItem: ProductItemDto) {
        didTapCell(productItem)
    }
}

fileprivate extension String {
    static let screenTitle = "Latest Collection"
}
