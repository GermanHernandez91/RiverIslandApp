import Foundation

enum NetworkError: LocalizedError {
    case invalidRequest
    case invalidResponse
    case noInternetConnection
    case noData
    case parseError
    case badRequest
}
