//
//  FavoriteGamesStore.swift
//  Farfetch Challenge
//
//  Created by Wallace Souza Silva on 31/07/18.
//  Copyright © 2018 WallaCorp. All rights reserved.
//

import Foundation

public protocol FavoriteGamesStoreSubscriber: class {
    func favoriteGamesChanged()
}

public protocol FavoriteGamesStore {
    
    func subscribe(_ subscriber: FavoriteGamesStoreSubscriber)
    func unsubscribe(_ subscriber: FavoriteGamesStoreSubscriber)
    
    func addFavorite(game: GameModel)
    func removeFavorite(game: GameModel)
    func retrieveFavoriteGames() -> [GameModel]
    
    func isFavorite(game: GameModel) -> Bool
}

