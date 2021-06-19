import XCTest
@testable import RiverIslandApp

final class ProductsRepoTest: XCTestCase {
    
    /**
        Scenario 1: SUCCESS
        Create repo and expect correct result from fetchProducts
     */
    func test_scenario1() {
        let sut = ProductsRepo(remoteDataSource: SuccessdingMockRemoteDataSource())
        
        sut.fetchProducts { result in
            switch result {
            case .success(let exepectedDto):
                XCTAssertEqual(exepectedDto, mockProductsDto)
            case .failure(let error):
                XCTAssertThrowsError(error)
            }
        }
    }
    
    /**
        Scenario 2: ERROR
        Create repo and expect error from fetchProducts
     */
    func test_scenario2() {
        let sut = ProductsRepo(remoteDataSource: FailingMockRemoteDataSource())
        
        sut.fetchProducts { result in
            switch result {
            case .success(_):
                XCTAssertThrowsError("Unit test should be failing")
            case .failure(let error):
                XCTAssertEqual(error as! NetworkError, NetworkError.invalidResponse)
            }
        }
    }
}

private final class SuccessdingMockRemoteDataSource: ProductsRepository {
    
    func fetchProducts(completion: @escaping ProductsResult) {
        completion(.success(mockProductsDto))
    }
}

private final class FailingMockRemoteDataSource: ProductsDataFetch {
 
    func fetchProducts(completion: @escaping ProductsResult) {
        completion(.failure(NetworkError.invalidResponse))
    }
}

private let mockProductsDto = ProductsDto(response: mockProductsResponse)
private let mockProductsResponse = ProductsResponse(products: [])
