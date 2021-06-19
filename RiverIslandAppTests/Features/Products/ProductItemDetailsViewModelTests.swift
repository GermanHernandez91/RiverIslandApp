import XCTest
@testable import RiverIslandApp

final class ProductItemDetailsViewModelTests: XCTestCase {
    
    /**
        Scenario 1
        Successfully passed in screen title
     */
    func test_scenario1() {
        let sut = generateViewModel()
        XCTAssertEqual(sut.title, "Product Details")
    }
    
    /**
        Scenario 2:
        Successfully productItem data passed in
     */
    func test_scenario2() {
        let sut = generateViewModel()
        XCTAssertEqual(sut.product, mockProductItemDto)
    }
    
}

private extension ProductItemDetailsViewModelTests {
    
    func generateViewModel() -> ProductItemDetailsViewModelProtocol {
        return ProductItemDetailsViewModel(productItem: mockProductItemDto, repository: MockProductsRepo())
    }
}

private final class MockProductsRepo: ProductsRepository {
    
    func fetchProducts(completion: @escaping ProductsResult) {
        completion(.success(mockProductDto))
    }
    
    func fetchProductImage(with urlString: String, completion: @escaping ProductImageResult) {
        completion(UIImage())
    }
}

private let mockProductDto = ProductsDto(response: mockProductsResponse)
private let mockProductsResponse = ProductsResponse(products: [])
private let mockProductItemDto = ProductItemDto(response: mockProductItemResponse)
private let mockProductItemResponse = ProductItemResponse(name: "", cost: "", prodid: "")
