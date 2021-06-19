import Foundation

struct ProductsDto {
    let products: [ProductItemDto]
    
    init(response: ProductsResponse) {
        self.products = response.products.map { .init(response: $0) }
    }
}

struct ProductItemDto {
    let name: String
    let cost: String
    let image: String
    
    init(response: ProductItemResponse) {
        self.name = response.name
        self.cost = response.cost
        self.image = "http://riverisland.scene7.com/is/image/RiverIsland/\(response.prodid)_main"
    }
}
