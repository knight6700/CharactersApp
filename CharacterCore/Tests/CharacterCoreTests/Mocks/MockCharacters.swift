import Foundation
import Models

struct MockCharacters {
    // Mock characters with IDs from 1 to 20
    static let mock: CharactersDTO = createMockCharacters(
        startID: 1,
        endID: 20,
        nextPage: "\(baseURL)/character?page=2",
        prevPage: nil
    )

    // Mock characters with IDs from 21 to 40
    static let mockMore: CharactersDTO = createMockCharacters(
        startID: 21,
        endID: 40,
        nextPage: nil,
        prevPage: "\(baseURL)/character?page=1"
    )

    // Filtered mock characters based on status
    static func filterMock(status: CharacterStatus) -> CharactersDTO {
        let characters = (1...20).map { id in
            createCharacter(id: id, status: status)
        }
        return CharactersDTO(
            info: Info(count: characters.count, pages: 2, next: "\(baseURL)/character?page=2", prev: nil),
            results: characters
        )
    }

    // Base URL for the API
    private static let baseURL = "https://rickandmortyapi.com"

    // Helper to create mock characters
    private static func createMockCharacters(
        startID: Int,
        endID: Int,
        nextPage: String?,
        prevPage: String?
    ) -> CharactersDTO {
        let characters = (startID...endID).map { id in
            createCharacter(
                id: id,
                status: id % 3 == 0 ? .alive : (id % 2 == 0 ? .dead : .unknown)
            )
        }
        return CharactersDTO(
            info: Info(count: characters.count, pages: 2, next: nextPage, prev: prevPage),
            results: characters
        )
    }

    // Helper to create an individual character
    private static func createCharacter(id: Int, status: CharacterStatus) -> CharacterInfo {
         CharacterInfo(
            id: id,
            name: "Character \(id)",
            species: "Species \(id)",
            type: "Type \(id)",
            status: status,
            gender: id % 2 == 0 ? "Male" : "Female",
            origin: Location(name: "Origin \(id)", url: "\(baseURL)/location/\(id)"),
            location: Location(name: "Location \(id)", url: "\(baseURL)/location/\(id)"),
            image: Optional("\(baseURL)/character/avatar/1.jpeg"),
            episode: ["Episode 1", "Episode 2", "Episode \(id)"],
            url: "\(baseURL)/character/\(id)",
            created: "2024-12-01T00:00:00Z"
        )
    }
}
