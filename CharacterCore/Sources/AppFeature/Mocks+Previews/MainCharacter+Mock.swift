#if DEBUG
import Foundation
import struct Models.MainCharacter
public extension MainCharacter {
    static let live: Self = Self(
        id: 1,
        name: "Zephyr",
        image: URL(string: "https://rickandmortyapi.com/api/character/avatar/361.jpeg"),
        species: "Elf",
        status: .alive,
        gender: "Male",
        location: "Forest"
    )

    static let dead: Self = Self(
        id: 1,
        name: "Zephyr",
        image: URL(string: "https://rickandmortyapi.com/api/character/avatar/361.jpeg"),
        species: "Elf",
        status: .dead,
        gender: "Male",
        location: "Forest"
    )

    static let unknown: Self = Self(
        id: 1,
        name: "Zephyr",
        image: URL(string: "https://rickandmortyapi.com/api/character/avatar/361.jpeg"),
        species: "Elf",
        status: .unknown,
        gender: "Male",
        location: "Forest"
    )
}
public extension Array where Element == MainCharacter {
    static let mock: [MainCharacter] = [
        MainCharacter(
            id: 1,
            name: "Zephyr",
            image: URL(string: "https://rickandmortyapi.com/api/character/avatar/361.jpeg"),
            species: "Elf",
            status: .alive,
            gender: "Male",
            location: "Forest"
        ),
        MainCharacter(
            id: 2,
            name: "Aurora",
            image: URL(string: "https://rickandmortyapi.com/api/character/avatar/361.jpeg"),
            species: "Human",
            status: .dead,
            gender: "Female",
            location: "Castle"
        ),
        MainCharacter(
            id: 3,
            name: "Thorne",
            image: URL(string: "https://rickandmortyapi.com/api/character/avatar/361.jpeg"),
            species: "Dwarf",
            status: .unknown,
            gender: "Non-binary",
            location: "Cavern"
        ),
        MainCharacter(
            id: 4,
            name: "Elara",
            image: URL(string: "https://rickandmortyapi.com/api/character/avatar/361.jpeg"),
            species: "Elf",
            status: .alive,
            gender: "Female",
            location: "Mountains"
        ),
        MainCharacter(
            id: 5,
            name: "Orin",
            image: URL(string: "https://rickandmortyapi.com/api/character/avatar/361.jpeg"),
            species: "Dragon",
            status: .dead,
            gender: "Male",
            location: "Sky"
        )
    ]

    static let mockMore: [MainCharacter] = [
        MainCharacter(
            id: 6,
            name: "Zephyr",
            image: URL(string: "https://rickandmortyapi.com/api/character/avatar/361.jpeg"),
            species: "Elf",
            status: .alive,
            gender: "Male",
            location: "Forest"
        ),
        MainCharacter(
            id: 7,
            name: "Aurora",
            image: URL(string: "https://rickandmortyapi.com/api/character/avatar/361.jpeg"),
            species: "Human",
            status: .dead,
            gender: "Female",
            location: "Castle"
        ),
        MainCharacter(
            id: 8,
            name: "Thorne",
            image: URL(string: "https://rickandmortyapi.com/api/character/avatar/361.jpeg"),
            species: "Dwarf",
            status: .unknown,
            gender: "Non-binary",
            location: "Cavern"
        ),
        MainCharacter(
            id: 9,
            name: "Elara",
            image: URL(string: "https://rickandmortyapi.com/api/character/avatar/361.jpeg"),
            species: "Elf",
            status: .alive,
            gender: "Female",
            location: "Mountains"
        ),
        MainCharacter(
            id: 10,
            name: "Orin",
            image: URL(string: "https://rickandmortyapi.com/api/character/avatar/361.jpeg"),
            species: "Dragon",
            status: .dead,
            gender: "Male",
            location: "Sky"
        )
    ]

}
#endif
