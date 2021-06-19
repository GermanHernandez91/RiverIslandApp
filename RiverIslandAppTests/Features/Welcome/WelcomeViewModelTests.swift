import XCTest
@testable import RiverIslandApp

final class WelcomeViewModelTests: XCTestCase {
    
    // MARK: - Properties
    private var didTapActionBtnExpectation: XCTestExpectation!
    
    // MARK: - Lifecycle
    override func setUp() {
        super.setUp()
        
        didTapActionBtnExpectation = self.expectation(description: "Action button has been tapped")
        didTapActionBtnExpectation.isInverted = true
    }
    
    override func tearDown() {
        
        didTapActionBtnExpectation = nil
        
        super.tearDown()
    }
    
    /**
        Scenario 1
        Successfully passed in screen title
     */
    func test_scenario1() {
        let sut = generateViewModel()
        driveExpectations()
        XCTAssertEqual(sut.title, "River Island")
    }
    
    /**
        Scenario 2
        Did tap action btn successfully
     */
    func test_scenario2() {
        didTapActionBtnExpectation.isInverted = false
        
        let sut = generateViewModel()
        sut.didActionBtnTapped()
        driveExpectations()
    }
}

private extension WelcomeViewModelTests {
    
    func generateViewModel() -> WelcomeViewModelProtocol {
        return WelcomeViewModel(actionBtnTapped: { [weak self] in self?.didTapActionBtnExpectation.fulfill() })
    }
    
    func driveExpectations() {
        wait(for: [didTapActionBtnExpectation], timeout: 0.1)
    }
}
