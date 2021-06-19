import Foundation

final class ProductsRemoteDataSource {
    
    // MARK: - Properties
    private var apiClient: APIClientProtocol
    
    // MARK: - Lifecycle
    init(apiClient: APIClientProtocol) {
        self.apiClient = apiClient
    }
}

extension ProductsRemoteDataSource: ProductsDataFetch {
    
    func fetchProducts(completion: @escaping ProductsResult) {
        
        let url = ProductsEndpoint.fetchProducts.url()
        let request = ProductsRequest(url: url, httpMethod: .GET)
        
        apiClient.fetch(model: ProductsResponse.self, request: request) { response in
            let result = convert(result: getResult(forResponse: response))
            
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchProductImage(with urlString: String, completion: @escaping ProductImageResult) {
        apiClient.downloadImage(from: urlString) { image in
            if let image = image {
                completion(image)
            } else {
                completion(nil)
            }
        }
    }
}

private func getResult<T>(forResponse response: Result<T, NetworkError>) -> Result<T, RepositoryError> {
    switch response {
    case .success(let model):
        return .success(model)
    case .failure(let error):
        return .failure(.convert(from: error))
    }
}

private func convert(result: Result<ProductsResponse, RepositoryError>) -> Result<ProductsDto, Error> {
    switch result {
    case .success(let response):
        return .success(.init(response: response))
    case .failure(let error):
        return .failure(error)
    }
}
