import Foundation
import Models
public protocol CharactersRepositoryType {
    func fetchCharacters(parameters: CharacterParameters) async throws -> CharactersDTO
}
