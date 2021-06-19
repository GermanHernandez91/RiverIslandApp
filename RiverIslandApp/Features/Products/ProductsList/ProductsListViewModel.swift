import UIKit

struct ProductsLListViewModel: ProductsListViewModelProtocol {
    
    // MARK: - Properties
    var title: String = .screenTitle
    var rowSize: CGFloat = 120
    var products: [ProductItemDto] = []
    var repository: ProductsRepository
    
    // MARK: - Lifecycle
    init(data: ProductsDto, repository: ProductsRepository) {
        self.products = data.products
        self.repository = repository
    }
}

fileprivate extension String {
    static let screenTitle = "Latest Collection"
}
