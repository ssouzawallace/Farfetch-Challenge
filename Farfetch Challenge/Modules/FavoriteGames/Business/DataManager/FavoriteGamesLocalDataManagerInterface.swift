//
//  FavoriteGamesLocalDataManagerInterface.swift
//  Farfetch Challenge
//
//  Created by Wallace Souza Silva on 05/08/18.
//  Copyright © 2018 WallaCorp. All rights reserved.
//

import Foundation

protocol FavoriteGamesLocalDataManagerInterface {
    func getFavoriteGames() -> [GameModel]
    var favoriteGamesChangedCallback: (()->Void)? { get set }
    func toggleFavorite(_ game: GameModel)
}
