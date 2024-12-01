//
//  File.swift
//  CharacterCore
//
//  Created by MahmoudFares on 01/12/2024.
//

import Foundation
import NetworkHorizon
import Models

enum CharactersService: CharacterServices {
    case characters(parameters: CharacterParameters)
}

extension CharactersService {
    var mainRoute: String {
        "character/"
    }
    
    var requestConfiguration: NetworkHorizon.RequestConfiguration {
        switch self {
        case .characters(let parameters):
            RequestConfiguration(
                method: .get,
                path: mainRoute,
                parameters: parameters,
                encoding: .UrlEncoding
            )
        }
    }
}
