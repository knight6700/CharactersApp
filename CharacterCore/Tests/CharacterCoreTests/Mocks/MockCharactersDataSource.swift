import Foundation
import AppFeature
import Models

struct MockCharactersDataSource: CharactersDataSourceType {
    enum MockError: Error {
        case networkError
    }

    var result: Result<CharactersDTO, Error>

    func getCharacters(parameters: CharacterParameters) async throws -> CharactersDTO {
        switch result {
        case .success(let charactersDTO):
            parameters.status == nil ?
            charactersDTO
            : CharactersDTO(
                info: charactersDTO.info,
                results: charactersDTO
                    .results?
                    .filter { $0.status?.rawValue == parameters.status }
            )
        case .failure(let error):
            throw error
        }
    }
}
