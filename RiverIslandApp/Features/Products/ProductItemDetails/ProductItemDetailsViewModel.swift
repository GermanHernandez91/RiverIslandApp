import Foundation

struct ProductItemDetailsViewModel: ProductItemDetailsViewModelProtocol {
    
    // MARK: - Properties
    var title: String = .screenTitle
    var product: ProductItemDto
    var repository: ProductsRepository
    
    // MARK: - Lifecycle
    init(productItem: ProductItemDto, repository: ProductsRepository) {
        self.product = productItem
        self.repository = repository
    }
}

fileprivate extension String {
    static let screenTitle = "Product Details"
}
