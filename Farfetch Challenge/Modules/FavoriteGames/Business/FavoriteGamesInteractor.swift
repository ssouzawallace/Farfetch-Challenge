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
    var localDataManager: FavoriteGamesLocalDataManagerInterface? {
        didSet {
            localDataManager?.favoriteGamesChangedCallback = favoriteGamesChanged
        }
    }    
    
    func favoriteGamesChanged() {
        presenter?.favoriteGamesChanged(localDataManager?.getFavoriteGames() ?? [])
    }
}

extension FavoriteGamesInteractor: FavoriteGamesInteractorInput {
    
    func fetchFavorites() {
        presenter?.favoriteGamesChanged(localDataManager?.getFavoriteGames() ?? [])
    }
    
    func toggleFavorite(forGame game: GameModel) {
        localDataManager?.toggleFavorite(game)
    }
}

