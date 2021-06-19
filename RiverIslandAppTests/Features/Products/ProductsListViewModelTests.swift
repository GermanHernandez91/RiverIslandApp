import XCTest
@testable import RiverIslandApp

final class ProducstListViewModelTest: XCTestCase {
    
    // MARK: - Properties
    private var didCellTappedExpectation: XCTestExpectation!
    
    // MARK: - Lifecycle
    override func setUp() {
        super.setUp()
        
        didCellTappedExpectation = self.expectation(description: "Cell has been tapped")
        didCellTappedExpectation.isInverted = true
        
    }
    
    override func tearDown() {
        
        didCellTappedExpectation = nil
        
        super.tearDown()
    }
    
    /**
        Scenario 1:
        Successfully passed in screen title
     */
    func test_scenario1() {
        let sut = generateViewModel()
        driveExpectations()
        XCTAssertEqual(sut.title, "Latest Collection")
    }
    
    /**
        Scenario 2:
        Successfully appetizers data passed in
     */
    func test_scenario2() {
        let sut = generateViewModel()
        driveExpectations()
        XCTAssertEqual(sut.products, mockProductsDto.products)
    }
    
    /**
        Scenario 3:
        Successfully passed in row size
     */
    func test_scenario3() {
        let sut = generateViewModel()
        driveExpectations()
        XCTAssertEqual(sut.rowSize, 120)
    }
    
    /**
        Scenario 4:
        Did tap  cell successfully
     */
    func test_scenario4() {
        didCellTappedExpectation.isInverted = false
        
        let sut = generateViewModel()
        sut.navigateToProductDetails(with: mockProductItemDto)
        
        driveExpectations()
    }
}

private extension ProducstListViewModelTest {
    
    func generateViewModel() -> ProductsListViewModelProtocol {
        return ProductsLListViewModel(data: mockProductsDto,
                                      repository: ProductsRepo(remoteDataSource: MockRemoteDataSource()),
                                      didTapCell: { [weak self] _ in self?.didCellTappedExpectation.fulfill() })
    }
    
    func driveExpectations() {
        wait(for: [didCellTappedExpectation], timeout: 0.1)
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
private let mockProductItemDto = ProductItemDto(response: mockProductItemResponse)
private let mockProductsResponse = ProductsResponse(products: [])
private let mockProductItemResponse = ProductItemResponse(name: "", cost: "", prodid: "")
