import Foundation

final class ProductsRepo {
    
    // MARK: - Properties
    private var remoteDataSource: ProductsDataFetch
    
    // MARK: - Lifecycle
    init(remoteDataSource: ProductsDataFetch) {
        self.remoteDataSource = remoteDataSource
    }
    
}

extension ProductsRepo: ProductsRepository {
    
    func fetchProducts(completion: @escaping ProductsResult) {
        remoteDataSource.fetchProducts(completion: completion)
    }
}
