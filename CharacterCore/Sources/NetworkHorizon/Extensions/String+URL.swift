

import Foundation

extension String {
    public func asURL() throws -> URL {
        guard let url = URL(string: self) else { throw APIError.missingURL }
        return url
    }
}
