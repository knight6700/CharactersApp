import Foundation
import Models

struct CharactersRepository: CharactersRepositoryType {
    private let dataSource: CharactersRemoteDataSourceType

    init(dataSource: CharactersRemoteDataSourceType) {
        self.dataSource = dataSource
    }

    func fetchCharacters(parameters: CharacterParameters) async throws -> CharactersDTO {
        try await dataSource.getCharacters(parameters: parameters)
    }
}
