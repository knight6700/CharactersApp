//
//  File.swift
//  CharacterCore
//
//  Created by MahmoudFares on 01/12/2024.
//

import Foundation
public struct CharactersViewData {
    public let totalPages: Int
    public let characters: [MainCharacter]
    public init(
        totalPages: Int,
        characters: [MainCharacter]
    ) {
        self.totalPages = totalPages
        self.characters = characters
    }
}
