import Foundation

typealias ProductsResult = (Result<ProductsDto, Error>) -> Void

protocol ProductsRepository: ProductsDataFetch { }

protocol ProductsDataFetch {
    func fetchProducts(completion: @escaping ProductsResult)
}
