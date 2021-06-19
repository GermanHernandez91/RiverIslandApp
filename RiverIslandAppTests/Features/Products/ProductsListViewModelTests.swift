import XCTest
@testable import RiverIslandApp

final class ProducstListViewModelTest: XCTestCase {
    
    /**
        Scenario 1:
        Successfully passed in screen title
     */
    func test_scenario1() {
        let sut = generateViewModel()
        XCTAssertEqual(sut.title, "Latest Collection")
    }
    
    /**
        Scenario 2:
        Successfully appetizers data passed in
     */
    func test_scenario2() {
        let sut = generateViewModel()
        XCTAssertEqual(sut.products, mockProductsDto.products)
    }
    
    /**
        Scenario 3:
        Successfully passed in row size
     */
    func test_scenario3() {
        let sut = generateViewModel()
        XCTAssertEqual(sut.rowSize, 120)
    }
}

private extension ProducstListViewModelTest {
    
    func generateViewModel() -> ProductsListViewModelProtocol {
        return ProductsLListViewModel(data: mockProductsDto, repository: ProductsRepo(remoteDataSource: MockRemoteDataSource()))
    }
}

private final class MockRemoteDataSource: ProductsDataFetch {
    
    func fetchProducts(completion: @escaping ProductsResult) {
        completion(.success(mockProductsDto))
    }
    
    func fetchProductImage(with urlString: String, completion: @escaping ProductImageResult) {
        completion(UIImage())
    }
}

private let mockProductsDto = ProductsDto(response: mockProductsResponse)
private let mockProductsResponse = ProductsResponse(products: [])
