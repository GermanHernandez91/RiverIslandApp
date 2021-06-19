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
    
    /**
        Scenario 3: SUCCESS
        Create repo and expect correct result from fetchProductImage
     */
    func test_scenario3() {
        let sut = ProductsRepo(remoteDataSource: SuccessdingMockRemoteDataSource())
        
        sut.fetchProductImage(with: "") { image in
            XCTAssertEqual(image, UIImage())
        }
    }
    
    /**
        Scenario 4: ERROR
        Create repo and expect nil  from fetchProductImage
     */
    func test_scenario4() {
        let sut = ProductsRepo(remoteDataSource: FailingMockRemoteDataSource())
        
        sut.fetchProductImage(with: "") { image in
            XCTAssertEqual(image, nil)
        }
    }
}

private final class SuccessdingMockRemoteDataSource: ProductsRepository {
    
    func fetchProducts(completion: @escaping ProductsResult) {
        completion(.success(mockProductsDto))
    }
    
    func fetchProductImage(with urlString: String, completion: @escaping ProductImageResult) {
        completion(UIImage())
    }
}

private final class FailingMockRemoteDataSource: ProductsDataFetch {
 
    func fetchProducts(completion: @escaping ProductsResult) {
        completion(.failure(NetworkError.invalidResponse))
    }
    
    func fetchProductImage(with urlString: String, completion: @escaping ProductImageResult) {
        completion(nil)
    }
}

private let mockProductsDto = ProductsDto(response: mockProductsResponse)
private let mockProductsResponse = ProductsResponse(products: [])
