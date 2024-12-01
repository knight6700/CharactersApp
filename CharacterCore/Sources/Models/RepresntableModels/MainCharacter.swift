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

