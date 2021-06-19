import Foundation

enum ProductsEndpoint: Endpoint {
    case fetchProducts
}

extension ProductsEndpoint {
    
    var stringValue: String {
        
        let endpoint = "/products.json"
        
        switch self {
        case .fetchProducts:
            return endpoint
        }
    }
}
