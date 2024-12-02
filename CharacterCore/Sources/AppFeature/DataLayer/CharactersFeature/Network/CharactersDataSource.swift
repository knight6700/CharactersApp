import Foundation
import Models
import NetworkHorizon

public protocol CharactersDataSourceType: RemoteAPI {
    func getCharacters(parameters: CharacterParameters) async throws -> CharactersDTO
}

struct CharactersDataSource: CharactersDataSourceType {
    func getCharacters(parameters: CharacterParameters) async throws -> CharactersDTO {
        try await request(CharactersService.characters(parameters: parameters))
    }
}
