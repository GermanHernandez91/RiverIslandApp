import UIKit

protocol APIClientProtocol {
    func fetch<T: Codable>(model: T.Type ,request: APIRequest, completion: @escaping (Result<T, NetworkError>) -> Void)
    func downloadImage(from urlString: String, completion: @escaping (UIImage?) -> Void)
}

final class APIClient: APIClientProtocol {
    
    private var networkSession: NetworkSession
    private let cache = NSCache<NSString, UIImage>()
    
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
    
    func downloadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
        let cacheKey = NSString(string: urlString)
                
        if let image = cache.object(forKey: cacheKey) {
            completion(image)
            return
        }
        
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        let dataTask = networkSession.session.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self,
                error == nil,
                let response = response as? HTTPURLResponse, response.statusCode == 200,
                let data = data,
                let image = UIImage(data: data) else {
                    completion(nil)
                    return
            }
            
            self.cache.setObject(image, forKey: cacheKey)
            completion(image)
        }
        
        dataTask.resume()
    }
}

extension APIClient {
    
    static func mock(bundleId: String) -> APIClientProtocol {
        MockApiClient(bundle: Bundle(identifier: bundleId)!)
    }
}
