import Foundation

final class MockApiClient: APIClientProtocol {
    
    // MARK: - Properties
    private var bundle: Bundle
    
    // MARK: - Lifecylce
    init(bundle: Bundle) {
        self.bundle = bundle
    }
    
    // MARK: - Methods
    func fetch<T>(model: T.Type, request: APIRequest, completion: @escaping (Result<T, NetworkError>) -> Void) where T : Decodable, T : Encodable {
        
        let requestPath = String(request.url.path.dropFirst()).replacingOccurrences(of: "/", with: "-")
        let urlComponents = requestPath.components(separatedBy: "-")
        
        let urlPath = urlComponents.joined(separator: "-")
        let fileExt = "json"
        
        guard let path = bundle.path(forResource: urlPath, ofType: fileExt) else {
            print("MockApiClient failed to load: \(urlPath).\(fileExt)")
            completion(.failure(.invalidResponse))
            return
        }
        
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe) else {
            completion(.failure(.noData))
            return
        }
        
        do {
            let result = try JSONDecoder().decode(model, from: data)
            completion(.success(result))
        } catch {
            completion(.failure(.parseError))
        }
    }
}
