//
//  File.swift
//  CharacterCore
//
//  Created by MahmoudFares on 01/12/2024.
//

import Foundation
import AppFeature
import Models

struct MockCharactersApi: CharactersApiType {
    enum MockError: Error {
        case networkError
    }
    
    var result: Result<CharactersDTO, Error>
    
    init(result: Result<CharactersDTO, Error>) {
        self.result = result
    }
    
    func getCharacters(parameters: CharacterParameters) async throws -> CharactersDTO {
        switch result {
        case .success(let charactersDTO):
            if parameters.status == nil {
                return charactersDTO
            }else {
                return  CharactersDTO(
                    info: charactersDTO.info,
                   results: charactersDTO.results?.filter { $0.status?.rawValue == parameters.status }
               )
            }
        case .failure(let error):
            throw error
        }
    }
}
