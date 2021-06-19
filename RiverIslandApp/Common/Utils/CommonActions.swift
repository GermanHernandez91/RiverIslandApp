import Foundation

struct CommonActions {
    let displayLoader: DisplayLoader
    let displayError: DisplayError
    
    init(displayLoader: @escaping DisplayLoader,
         displayError: @escaping DisplayError) {
        
        self.displayLoader = displayLoader
        self.displayError = displayError
    }
}
