import AppFeature
import Foundation
import Models

extension LoadingState: Equatable {
    public static func == (lhs: LoadingState, rhs: LoadingState) -> Bool {
        switch (lhs, rhs) {
        case (.loading, .loading):
            return true
        case (
            .loaded(let lhsItems, let lhsRefreshable),
            .loaded(let rhsItems, let rhsRefreshable)
        ):
            return lhsItems == rhsItems && lhsRefreshable == rhsRefreshable
        case (.error(let lhsMessage), .error(let rhsMessage)):
            return lhsMessage == rhsMessage
        default:
            return false
        }
    }
}
struct TimeoutError: Error {}
extension MainCharacter {
    init(characterInfo: CharacterInfo) {
        self.init(
            id: characterInfo.id ?? 0,
            name: characterInfo.name ?? "N/A",
            image: URL(string: characterInfo.image ?? ""),
            species: characterInfo.species ?? "N/A",
            status: FilterStatus(
                rawValue: characterInfo.status?.rawValue ?? "N/A") ?? .unknown,
            gender: characterInfo.gender ?? "N/A",
            location: characterInfo.location?.name ?? "N/A"
        )
    }
}
