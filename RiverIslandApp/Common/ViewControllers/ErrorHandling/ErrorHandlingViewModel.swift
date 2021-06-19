import Foundation

struct ErrorHandlingViewModel: ErrorHandlingViewModelProtocol {
    
    // MARK: - Properties
    var errorMessage: ErrorMessage?
    var action: () -> Void = {}
    
    // MARK: - Lifecylce
    init(errorMessage: ErrorMessage?,
         action: @escaping () -> Void) {
        
        self.errorMessage = errorMessage
        self.action = action
    }
}
