import Foundation

struct ProductsResponse: Codable {
    let products: [ProductItemResponse]
    
    enum CodingKeys: String, CodingKey {
        case products = "Products"
    }
}

struct ProductItemResponse: Codable {
    let name: String
    let cost: String
    let prodid: String
}
