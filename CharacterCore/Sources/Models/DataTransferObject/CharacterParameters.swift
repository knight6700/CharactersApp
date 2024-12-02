import Foundation

public struct CharacterParameters: Encodable {
    public var page: Int
    public var status: String?
    public init(
        page: Int,
        status: String? = nil
    ) {
        self.page = page
        self.status = status
    }
}
