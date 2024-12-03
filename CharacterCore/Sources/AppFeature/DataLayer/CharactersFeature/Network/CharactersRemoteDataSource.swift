import Foundation
import Models
import NetworkHorizon

public protocol CharactersRemoteDataSourceType: RemoteAPI {
    func getCharacters(parameters: CharacterParameters) async throws -> CharactersDTO
}

struct CharactersRemoteDataSource: CharactersRemoteDataSourceType {
    func getCharacters(parameters: CharacterParameters) async throws -> CharactersDTO {
        try await request(CharactersService.characters(parameters: parameters))
    }
}
