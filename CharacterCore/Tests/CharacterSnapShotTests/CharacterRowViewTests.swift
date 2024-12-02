import Foundation
@testable import AppFeature
import SnapshotTesting
import SwiftUI
import Models
import XCTest

@MainActor
final class CharacterRowViewTests: XCTestCase {
    func testCharacterRowViewTest() {
        let view = CharacterRowView(character: .live)
            .frame(width: 350)
        assertSnapshot(of: view, as: .image)
    }

    func testCharacterRowViewDeadTest() {
        let view = CharacterRowView(character: .dead)
            .frame(width: 350)
        assertSnapshot(of: view, as: .image)
    }

    func testCharacterRowViewUnknownTest() {
        let view = CharacterRowView(character: .unknown)
            .frame(width: 350)
        assertSnapshot(of: view, as: .image)
    }
}
