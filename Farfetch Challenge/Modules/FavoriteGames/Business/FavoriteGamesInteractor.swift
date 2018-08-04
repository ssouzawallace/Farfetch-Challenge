//
//  FavoriteGamesInteractor.swift
//  Farfetch Challenge
//
//  Created by Wallace Souza Silva on 02/08/18.
//  Copyright © 2018 WallaCorp. All rights reserved.
//

import Foundation

class FavoriteGamesInteractor {
    var presenter: FavoriteGamesInteractorOutput?
    
    init() {
        LocalDataStore.shared.subscribe(self)
    }
    
    deinit {
        LocalDataStore.shared.unsubscribe(self)
    }
}

extension FavoriteGamesInteractor: FavoriteGamesInteractorInput {
    func fetchFavorites() {
        presenter?.favoriteGamesChanged(LocalDataStore.shared.getFavoriteGames())
    }
    
    func toggleFavorite(forGame game: GameModel) {
        if LocalDataStore.shared.isFavorite(game: game) {
            LocalDataStore.shared.removeFavorite(game: game)
        } else {
            LocalDataStore.shared.addFavorite(game: game)
        }
    }
}

extension FavoriteGamesInteractor: FavoriteGamesStoreSubscriber {
    func favoriteGamesChanged() {
        presenter?.favoriteGamesChanged(LocalDataStore.shared.getFavoriteGames())
        // TODO
    }
}
