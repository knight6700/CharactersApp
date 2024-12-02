import Foundation

public protocol RemoteAPI: APIErrorHandler {
     func request<T: Codable>(_ service: RemoteService) async throws -> T
}

public extension RemoteAPI {
    func request<T: Decodable>(_ service: RemoteService) async throws -> T {
        do {
            let urlRequest = try service.asURLRequest()
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            if let httpResponse = response as? HTTPURLResponse {
                guard (200...299).contains(httpResponse.statusCode) else {
                    throw handleNetworkResponse(data: data, response: response)
                }
            }
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let decodedData = try decoder.decode(T.self, from: data)
            return decodedData
        } catch let decodingError as DecodingError {
            throw APIError.jsonParsingFailed(error: decodingError)
        } catch {
            throw APIError.unknown(error)
        }
    }}
