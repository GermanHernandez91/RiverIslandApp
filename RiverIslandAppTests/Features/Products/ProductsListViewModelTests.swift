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
}

private extension ProducstListViewModelTest {
    
    func generateViewModel() -> ProductsListViewModelProtocol {
        return ProductsLListViewModel()
    }
}
