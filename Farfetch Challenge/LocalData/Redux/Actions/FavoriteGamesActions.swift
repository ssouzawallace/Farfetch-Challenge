//
//  Actions.swift
//  Farfetch Challenge
//
//  Created by Wallace Souza Silva on 31/07/18.
//  Copyright © 2018 WallaCorp. All rights reserved.
//

import Foundation
import ReSwift

protocol FavoriteGamesAction: Action {
    var game: GameModel { get }
}

struct FavoriteGamesActionAdd: FavoriteGamesAction {
    var game: GameModel
}

struct FavoriteGamesActionRemove: FavoriteGamesAction {
    var game: GameModel
}
