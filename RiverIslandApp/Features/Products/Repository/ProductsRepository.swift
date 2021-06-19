import UIKit

typealias ProductsResult = (Result<ProductsDto, Error>) -> Void
typealias ProductImageResult = (UIImage?) -> Void

protocol ProductsRepository: ProductsDataFetch { }

protocol ProductsDataFetch {
    func fetchProducts(completion: @escaping ProductsResult)
    func fetchProductImage(with urlString: String, completion: @escaping ProductImageResult)
}
