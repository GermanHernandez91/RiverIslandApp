import Foundation

protocol APIClientProtocol {
    func fetch<T: Codable>(model: T.Type ,request: APIRequest, completion: @escaping (Result<T, NetworkError>) -> Void)
}

final class APIClient: APIClientProtocol {
    
    private var networkSession: NetworkSession
    
    init(networkSession: NetworkSession) {
        self.networkSession = networkSession
    }
    
    func fetch<T>(model: T.Type, request: APIRequest, completion: @escaping (Result<T, NetworkError>) -> Void) where T : Decodable, T : Encodable {
        
        let dataTask = networkSession.session.dataTask(with: request.urlRequest as URLRequest) { data, response, error in
            
            if let _ = error {
                completion(.failure(.noInternetConnection))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            DispatchQueue.main.async {
                do {
                    let decoder = JSONDecoder()
                    let results = try decoder.decode(model, from: data)
                    completion(.success(results))
                } catch {
                    completion(.failure(.parseError))
                }
            }
        }
        
        dataTask.resume()
    }
}

extension APIClient {
    
    static func mock(bundleId: String) -> APIClientProtocol {
        MockApiClient(bundle: Bundle(identifier: bundleId)!)
    }
}
