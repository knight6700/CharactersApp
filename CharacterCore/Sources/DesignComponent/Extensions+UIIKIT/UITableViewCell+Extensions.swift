import UIKit

public extension UITableViewCell {
    static var identifier: String { String(describing: Self.self) }
}
