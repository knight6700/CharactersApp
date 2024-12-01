import Foundation

extension Bundle {
    func info<T>(forKey key: String) -> T? {
        return Bundle.main.infoDictionary?[key] as? T
    }
}
