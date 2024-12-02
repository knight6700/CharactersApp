import Foundation
import AppFeature
import Models

class MockCharactersRepository: CharactersRepositoryType {
    let api: CharactersApiType
    var params: CharacterParameters?
    var fetchCalled = 0

    init(api: CharactersApiType) {
        self.api = api
    }

    func fetchCharacters(parameters: CharacterParameters) async throws -> CharactersDTO {
        params = parameters
        fetchCalled += 1
        return try await api.getCharacters(parameters: parameters)
    }
}
