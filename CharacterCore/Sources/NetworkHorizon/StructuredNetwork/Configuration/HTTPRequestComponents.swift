import Foundation

public typealias Parameters = Encodable

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

public struct HTTPHeader {
    public let name: String
    public let value: String
}
