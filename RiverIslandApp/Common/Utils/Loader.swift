import Foundation

typealias DisplayLoader = (Loader) -> Void

struct Loader {
    let show: Bool
    let transparent: Bool
    let messages: [String]
    
    init(show: Bool, transparent: Bool = false, messages: [String] = []) {
        self.show = show
        self.transparent = transparent
        self.messages = messages
    }
}
