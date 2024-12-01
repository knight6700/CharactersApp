//
//  File.swift
//  CharacterCore
//
//  Created by MahmoudFares on 29/11/2024.
//

import Foundation
import struct Models.MainCharacter

class CharacterDetailsViewModel: ViewModelType {
    struct State {
        var character: MainCharacter
        var image: URL? {
            character.image
        }
    }
    enum Action {
        case backButtonTapped
    }
    var state: State
   weak var appRouter: AppRouter?
    init(
        state: State,
        appRouter: AppRouter
    ) {
        self.state = state
        self.appRouter = appRouter
    }
    
    func trigger(_ action: Action) {
        switch action {
        case .backButtonTapped:
            appRouter?.pop(animated: true)
        }
    }
}
