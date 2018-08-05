//
//  FavoriteGamesLocalDataManager.swift
//  Farfetch Challenge
//
//  Created by Wallace Souza Silva on 05/08/18.
//  Copyright © 2018 WallaCorp. All rights reserved.
//

import Foundation

class FavoriteGamesLocalDataManager: FavoriteGamesLocalDataManagerInterface {
    var favoriteGamesChangedCallback: (() -> Void)?
    
    init() {
        LocalDataStore.shared.subscribe(self)
    }
    
    deinit {
        LocalDataStore.shared.unsubscribe(self)
    }
    
    func getFavoriteGames() -> [GameModel] {
        return LocalDataStore.shared.getFavoriteGames()
    }
    
    func toggleFavorite(_ game: GameModel) {
        if LocalDataStore.shared.isFavorite(game: game) {
            LocalDataStore.shared.removeFavorite(game: game)
        } else {
            LocalDataStore.shared.addFavorite(game: game)
        }
    }
}

extension FavoriteGamesLocalDataManager: FavoriteGamesStoreSubscriber {
    func favoriteGamesChanged() {
        favoriteGamesChangedCallback?()
    }
}
