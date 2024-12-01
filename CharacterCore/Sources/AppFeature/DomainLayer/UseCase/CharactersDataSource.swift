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
