//
//  File.swift
//  CharacterCore
//
//  Created by MahmoudFares on 01/12/2024.
//

import Foundation
import AppFeature
import Models

class MockCharactersRepository: CharactersRepositoryType {
    var api: CharactersApiType
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

