import Foundation

struct ProductsLListViewModel: ProductsListViewModelProtocol {
    
    // MARK: - Properties
    var title: String = .screenTitle
}

fileprivate extension String {
    static let screenTitle = "Latest Collection"
}
