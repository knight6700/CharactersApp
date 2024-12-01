//
//  CharacterParameters.swift
//  CharactersApp
//
//  Created by MahmoudFares on 29/11/2024.
//

import Foundation
public struct CharacterParameters: Encodable {
    public var page: Int
    public var status: String? = nil
    public init(
        page: Int,
        status: String? = nil
    ) {
        self.page = page
        self.status = status
    }
}
