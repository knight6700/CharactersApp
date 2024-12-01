//
//  File.swift
//  CharacterCore
//
//  Created by MahmoudFares on 01/12/2024.
//

import Foundation
import Models

struct CharactersRepository: CharactersRepositoryType {
    private let api: CharactersApiType

    init(api: CharactersApiType = CharactersApi()) {
        self.api = api
    }

    func fetchCharacters(parameters: CharacterParameters) async throws -> CharactersDTO {
        try await api.getCharacters(parameters: parameters)
    }
}
