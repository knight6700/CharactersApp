//
//  File.swift
//  CharacterCore
//
//  Created by MahmoudFares on 01/12/2024.
//

import Foundation

public struct CharactersDTO: Decodable {
    public let info: Info?
    public let results: [CharacterInfo]?
    public init(
        info: Info?,
        results: [CharacterInfo]?
    ) {
        self.info = info
        self.results = results
    }
}

// MARK: - Info
public struct Info: Decodable {
    public let count, pages: Int?
    public let next, prev: String?
    public init(
        count: Int?,
        pages: Int?,
        next: String?,
        prev: String?
    ) {
        self.count = count
        self.pages = pages
        self.next = next
        self.prev = prev
    }
}

// MARK: - Result
public struct CharacterInfo: Decodable {
    public let id: Int?
    public let name, species, type: String?
    public let status: CharacterStatus?
    public let gender: String?
    public let origin, location: Location?
    public let image: String?
    public let episode: [String]?
    public let url: String?
    public let created: String?
    public init(
        id: Int?,
        name: String?,
        species: String?,
        type: String?,
        status: CharacterStatus?,
        gender: String?,
        origin: Location?,
        location: Location?,
        image: String?,
        episode: [String]?,
        url: String?,
        created: String?
    ) {
        self.id = id
        self.name = name
        self.species = species
        self.type = type
        self.status = status
        self.gender = gender
        self.origin = origin
        self.location = location
        self.image = image
        self.episode = episode
        self.url = url
        self.created = created
    }
}

// MARK: - Location
public struct Location: Decodable {
    public let name: String?
    public let url: String?
    public init(
        name: String?,
        url: String?
    ) {
        self.name = name
        self.url = url
    }
}

public enum CharacterStatus: String, Decodable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
}
