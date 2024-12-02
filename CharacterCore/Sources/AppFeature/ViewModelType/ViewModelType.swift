import Foundation

protocol StateMachine {
    associatedtype State
    associatedtype Action

    var state: State { get set }
    
    /// Trigger an action that may modify the state.
    func trigger(_ action: Action) async throws
}

/// Protocol for types that provide a view state.
protocol StateRendering {
    associatedtype ViewState

    /// The view state that the conforming type presents.
    var viewState: ViewState { get }
}

/// A protocol for ViewModels that combine StateMachine and view StateRendering.
protocol CompositeStateViewModel: StateMachine, StateRendering { }
