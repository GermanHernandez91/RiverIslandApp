import XCTest
@testable import RiverIslandApp

final class ProductsRemoteDataSourceTests: XCTestCase {
    
    // MARK: - Properties
    private var products: ProductsDto?
    private var fetchDataExpectation: XCTestExpectation!

    // MARK: - Lifecylce
    override func setUp() {
        super.setUp()
        
        fetchDataExpectation = expectation(description: "Products fetched")
    }
    
    override func tearDown() {
        
        fetchDataExpectation = nil
        
        super.tearDown()
    }
    
    /**
        Scenario 1
        Create the data source and fetch data
     */
    func test_scenario1() {
        let sut = generateSut()
        
        sut.fetchProducts { [weak self] result in
            guard let self = self else {  return }
            
            switch result {
            case .success(let data):
                self.products = data
                self.fetchDataExpectation.fulfill()
                
            case .failure(let error):
                XCTAssertThrowsError(error)
            }
        }
        
        waitForExpectations(timeout: 0.1) { [weak self] error in
            XCTAssertNotNil(self?.products)
        }
    }
}

private extension ProductsRemoteDataSourceTests {
    
    func generateSut() -> ProductsDataFetch {
        let apiClient = APIClient.mock(bundleId: bundleId)
        return ProductsRemoteDataSource(apiClient: apiClient)
    }
}

private let bundleId = "com.example.germanhernandez.RiverIslandAppTests"
