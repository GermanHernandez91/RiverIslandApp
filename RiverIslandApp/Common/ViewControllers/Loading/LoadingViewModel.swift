import Foundation

struct LoadingViewModel: LoadingViewModelProtocol {
    
    let transparentStyle: Bool
    let loadingMessage: [String]
    
    init(transparentStyle: Bool, loadingMessage: [String]) {
        self.transparentStyle = transparentStyle
        self.loadingMessage = loadingMessage
    }
}
