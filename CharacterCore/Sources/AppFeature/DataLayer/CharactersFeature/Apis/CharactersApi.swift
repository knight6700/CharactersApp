import Foundation
import Models
import NetworkHorizon

public protocol CharactersApiType: RemoteAPI {
    func getCharacters(parameters: CharacterParameters) async throws -> CharactersDTO
}

struct CharactersApi: CharactersApiType {
    func getCharacters(parameters: CharacterParameters) async throws -> CharactersDTO {
        try await request(CharactersService.characters(parameters: parameters))
    }
}
