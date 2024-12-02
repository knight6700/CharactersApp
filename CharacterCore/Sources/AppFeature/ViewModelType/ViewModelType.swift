import Foundation

protocol ViewModelType {
    associatedtype State
    associatedtype Action

    var state: State { get set }
    func trigger(_ action: Action) async throws
}
