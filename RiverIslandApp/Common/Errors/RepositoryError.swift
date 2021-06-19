import Foundation

enum RepositoryError: Error {
    case noInternetConnection
    case unknown
    case unexpectedDataFormat
    case noData
}

extension RepositoryError {
    
    static func convert(from networkError: NetworkError) -> RepositoryError {
        
        switch networkError {
        case .badRequest: return .unknown
        case .invalidRequest: return .unknown
        case .invalidResponse: return .unknown
        case .noInternetConnection: return .noInternetConnection
        case .parseError: return .unexpectedDataFormat
        case .noData: return .noData
        }
    }
}
