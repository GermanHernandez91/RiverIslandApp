import Foundation

protocol APIRequest {
    var url: URL { get }
    var httpMethod: HttpMethod { get }
    var contentType: String { get }
}

extension APIRequest {
    
    var urlRequest: NSMutableURLRequest {
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        return request
    }
    
    var contentType: String {
        return "application/json"
    }
}
