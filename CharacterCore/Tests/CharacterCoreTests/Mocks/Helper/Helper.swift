//
//  File.swift
//  CharacterCore
//
//  Created by MahmoudFares on 01/12/2024.
//

import Foundation
import AppFeature
import Models

struct TimeoutError: Error {}

extension LoadingState: Equatable {
    public static func == (lhs: LoadingState, rhs: LoadingState) -> Bool {
        switch (lhs, rhs) {
        case (.loading, .loading):
            return true // Both are in the loading state, no associated values to compare
        case (.loaded(let lhsItems, let lhsRefreshable), .loaded(let rhsItems, let rhsRefreshable)):
            // Compare the items array and refreshable flag
            return lhsItems == rhsItems && lhsRefreshable == rhsRefreshable
        case (.error(let lhsMessage), .error(let rhsMessage)):
            // Compare the error messages
            return lhsMessage == rhsMessage
        default:
            return false
        }
    }
}
extension MainCharacter {
    init(characterInfo: CharacterInfo) {
        self.init(
            id: characterInfo.id ?? 0,
            name: characterInfo.name ?? "N/A",
            image: URL(string: characterInfo.image ?? ""),
            species: characterInfo.species ?? "N/A",
            status: FilterStatus(rawValue: characterInfo.status?.rawValue ?? "N/A") ?? .unknown,
            gender: characterInfo.gender ?? "N/A",
            location: characterInfo.location?.name ?? "N/A"
        )
    }
}
