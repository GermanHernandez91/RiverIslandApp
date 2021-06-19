import Foundation

protocol Endpoint {
    
    var stringValue: String { get }
    
    func url() -> URL
}

extension Endpoint {
    
    func url() -> URL {
        let result = Constants.BASE_URL + stringValue
        return URL(string: result)!
    }
}
