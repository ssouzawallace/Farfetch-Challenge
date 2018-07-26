//
//  GameViewModel.swift
//  Farfetch Challenge
//
//  Created by Wallace Souza Silva on 25/07/18.
//  Copyright © 2018 WallaCorp. All rights reserved.
//

import Foundation

class GameViewModel {
    let game: GameModel
    
    init(game: GameModel) {
        self.game = game
    }
    
    func boxArtUrl(forHeight height: Int) -> String {
        let width = height*8/6
        return game.boxArtUrl
            .replacingOccurrences(of: "{width}", with: width.description)
            .replacingOccurrences(of: "{height}", with: height.description)
    }
}
