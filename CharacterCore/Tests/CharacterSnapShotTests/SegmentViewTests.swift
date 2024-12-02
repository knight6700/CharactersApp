import Foundation
import Models
import SnapshotTesting
import SwiftUI
import XCTest

@testable import DesignComponent

@MainActor
final class SegmentViewTests: XCTestCase {
    func testSegmentViewTest() {
        let view = SegmentView(
            selectedStatus: .constant(.alive),
            items: FilterStatus.allCases
        )
        .frame(width: 350)
        assertSnapshot(of: view, as: .image)
    }

    func testSegmentViewDeadTest() {
        let view = SegmentView(
            selectedStatus: .constant(.dead),
            items: FilterStatus.allCases
        )
        .frame(width: 350)
        assertSnapshot(of: view, as: .image)
    }

    func testSegmentViewUnkownTest() {
        let view = SegmentView(
            selectedStatus: .constant(.unknown),
            items: FilterStatus.allCases
        )
        .frame(width: 350)
        assertSnapshot(of: view, as: .image)
    }
}
