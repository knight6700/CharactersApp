import Foundation

public struct CharactersViewData {
    public let totalPages: Int
    public let characters: [MainCharacter]
    public init(
        totalPages: Int,
        characters: [MainCharacter]
    ) {
        self.totalPages = totalPages
        self.characters = characters
    }
}
