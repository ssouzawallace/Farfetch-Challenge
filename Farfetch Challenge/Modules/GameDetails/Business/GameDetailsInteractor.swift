//
//  GameDetailsInteractor.swift
//  Farfetch Challenge
//
//  Created by Wallace Souza Silva on 31/07/18.
//  Copyright © 2018 WallaCorp. All rights reserved.
//

import Foundation

class GameDetailsInteractor {
    var presenter: GameDetailsInteractorOutput?
    
    private let game: GameModel
    
    required init(withGame game: GameModel) {
        self.game = game
        LocalDataStore.shared.subscribe(self)
    }
    
    deinit {
        LocalDataStore.shared.unsubscribe(self)
    }
}

extension GameDetailsInteractor: GameDetailsInteractorInput {

    func getGame() -> GameModel {
        return game
    }
    
    func toggleFavoriteStatus() {
        if LocalDataStore.shared.isFavorite(game: game) {
           LocalDataStore.shared.removeFavorite(game: game)
        } else {
            LocalDataStore.shared.addFavorite(game: game)
        }
    }
}

extension GameDetailsInteractor: FavoriteGamesStoreSubscriber {
    func favoriteGamesChanged() {
        presenter?.gameFavoriteStatusChanged()
    }
}
