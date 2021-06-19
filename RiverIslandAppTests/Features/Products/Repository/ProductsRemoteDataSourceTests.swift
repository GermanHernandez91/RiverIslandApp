import XCTest
@testable import RiverIslandApp

final class ProductsRemoteDataSourceTests: XCTestCase {
    
    // MARK: - Properties
    private var products: ProductsDto?
    private var productImage: UIImage?
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
    
    /**
        Scenario 2
        Create the data source and fetch product image
     */
    func test_scenario2() {
        let sut = generateSut()
        
        let urlString = "http://riverisland.scene7.com/is/image/RiverIsland/691807_main"
        
        sut.fetchProductImage(with: urlString) { [weak self] image in
            guard let self = self else { return }
            
            if let image = image {
                self.productImage = image
                self.fetchDataExpectation.fulfill()
            } else {
                XCTAssertThrowsError("Image not loaded")
            }
        }
        
        waitForExpectations(timeout: 0.1) { [weak self] error in
            XCTAssertNotNil(self?.productImage)
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
