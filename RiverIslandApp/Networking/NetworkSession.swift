import Foundation

struct NetworkSession {
    let session: URLSession
    
    init(session: URLSession) {
        self.session = session
    }
}

extension NetworkSession {
    
    static func defaultSession() -> NetworkSession {
        let session = URLSession(configuration: .default)
        return NetworkSession(session: session)
    }
}
