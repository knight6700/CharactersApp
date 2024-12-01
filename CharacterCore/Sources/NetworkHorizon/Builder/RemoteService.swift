
import Foundation

public protocol RemoteService {
    var fullURL: String { get }
    var requestConfiguration: RequestConfiguration { get }
}

public extension RemoteService {
    func asURLRequest() throws -> URLRequest {
        let url = try fullURL
            .asURL()
            .appendingPathComponent(requestConfiguration.path)
        var request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad)
        request.httpMethod = requestConfiguration.method.rawValue
        if let headers = requestConfiguration.headers {
            for header in headers {
                request.setValue(header.value, forHTTPHeaderField: header.name)
            }
        }
        if let parameters = requestConfiguration.parameters {
            try requestConfiguration.encoding?.encode(
                urlRequest: &request, parameters: parameters)
        }
        return request
    }
}

public protocol CharacterServices: RemoteService {
    var mainRoute: String { get }
}
extension CharacterServices {
    public var fullURL: String {
        return "https://rickandmortyapi.com/api/"
      }
}
