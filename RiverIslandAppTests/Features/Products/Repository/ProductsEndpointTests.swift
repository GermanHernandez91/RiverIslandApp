import XCTest
@testable import RiverIslandApp

final class ProductsEndpointTests: XCTestCase {
    
    /**
        Scenario 1
        Check that fetchProducts returns the correct url
     */
    func test_scenario1() {
        let endpoint = ProductsEndpoint.fetchProducts
        let url = endpoint.url()
        XCTAssertEqual(url.absoluteString, Constants.BASE_URL + "/products.json")
    }
}
