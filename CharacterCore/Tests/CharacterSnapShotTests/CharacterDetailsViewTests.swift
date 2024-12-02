import Foundation
@testable import AppFeature
import SnapshotTesting
import SwiftUI
import Models
import XCTest

@MainActor
final class CharacterDetailsViewTests: XCTestCase {
    func testCharacterDetailsView() {
        let view = NavigationStack {
            CharacterDetailsView(
                viewModel: CharacterDetailsViewModel(
                    state: CharacterDetailsViewModel.State(character: .live),
                    appRouter: AppRouter()
                )
            )
        }
        let hostingController = UIHostingController(rootView: view)
        assertSnapshot(of: hostingController, as: .image(on: .iPhone13))
    }
}
