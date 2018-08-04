//
//  Reducers.swift
//  Farfetch Challenge
//
//  Created by Wallace Souza Silva on 31/07/18.
//  Copyright © 2018 WallaCorp. All rights reserved.
//

import Foundation
import ReSwift

func favoriteGamesReducer(action: FavoriteGamesAction, state: AppState?) -> AppState {
    var state = state ?? AppState()
    let game = action.game
    
    switch action {
    case _ as FavoriteGamesActionRemove:
        guard let gameIndex = state.favoriteGames.index(of: game) else {
            print("ERROR: trying to remove game that is not favorite")
            return state
        }
        state.favoriteGames.remove(at: gameIndex)
        break
    case _ as FavoriteGamesActionAdd:
        state.favoriteGames.append(game)
        break
    default:
        break
    }
    return state
}

func reducer(action: Action, state: AppState?) -> AppState {
    if let action = action as? FavoriteGamesAction {
        return favoriteGamesReducer(action: action, state: state)
    }
    
    return state ?? AppState()
}
