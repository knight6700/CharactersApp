import Foundation
import AppFeature
import Models

struct MockCharactersUseCase: CharactersUseCaseType {
    var charactersRepository: CharactersRepositoryType

    init(
        repository: CharactersRepositoryType
    ) {
        self.charactersRepository = repository
    }

    // Mock the `getAllCharacters` method
    func getAllCharacters(parameters: CharacterParameters) async throws -> CharactersViewData {
       let response = try await charactersRepository.fetchCharacters(parameters: parameters)
        return CharactersViewData(
            totalPages: response.info?.pages ?? .zero,
            characters: response.results?.map { MainCharacter(dto: $0) } ?? []
        )
    }
}
