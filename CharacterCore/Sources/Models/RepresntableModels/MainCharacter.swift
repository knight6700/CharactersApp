//
//  MainCharacter.swift
//  CharactersApp
//
//  Created by MahmoudFares on 29/11/2024.
//

import Foundation
public struct MainCharacter: Hashable, Equatable, Identifiable {
    public let id: Int
    public let name: String
    public let image: URL?
    public let species: String
    public let status: FilterStatus
    public let gender: String
    public let location: String
    
    public init(
        id: Int,
        name: String,
        image: URL?,
        species: String,
        status: FilterStatus,
        gender: String,
        location: String
    ) {
        self.id = id
        self.name = name
        self.image = image
        self.species = species
        self.status = status
        self.gender = gender
        self.location = location
    }
}

public enum FilterStatus: String, CaseIterable, Identifiable, Equatable, Hashable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "Unknown"
    public var id: String {
        rawValue
    }
}
