//
//  File.swift
//  CharacterCore
//
//  Created by MahmoudFares on 01/12/2024.
//

import Foundation
import Models
public protocol CharactersDataSourceType {
    var charactersRepository: CharactersRepositoryType { get }
    func getAllCharacters(parameters: CharacterParameters) async throws -> CharactersViewData
}

public struct CharactersDataSource: CharactersDataSourceType {
    public var charactersRepository: CharactersRepositoryType
    
    public func getAllCharacters(parameters: Models.CharacterParameters) async throws -> CharactersViewData {
        let data = try await charactersRepository.fetchCharacters(parameters: parameters)
        let characters = data.results?.compactMap { MainCharacter(dto: $0) } ?? []
        return CharactersViewData(totalPages: data.info?.pages ?? .zero, characters: characters)
    }
}

public extension MainCharacter {
    init(dto: CharacterInfo) {
        self.init(
            id: dto.id ?? 0,
            name: dto.name ?? "N/A",
            image: URL(string: dto.image ?? ""),
            species: dto.species ?? "N/A",
            status: FilterStatus(rawValue: dto.status?.rawValue ?? "N/A") ?? .unknown,
            gender: dto.gender ?? "N/A",
            location: dto.location?.name ?? "N/A"
        )
    }
}
