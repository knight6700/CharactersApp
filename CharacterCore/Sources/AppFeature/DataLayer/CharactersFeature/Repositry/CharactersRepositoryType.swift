//
//  File.swift
//  CharacterCore
//
//  Created by MahmoudFares on 01/12/2024.
//

import Foundation
import Models
public protocol CharactersRepositoryType {
    func fetchCharacters(parameters: CharacterParameters) async throws -> CharactersDTO
}
