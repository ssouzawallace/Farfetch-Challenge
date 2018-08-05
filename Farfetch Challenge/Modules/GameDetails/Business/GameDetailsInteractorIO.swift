//
//  GameDetailsInteractorIO.swift
//  Farfetch Challenge
//
//  Created by Wallace Souza Silva on 02/08/18.
//  Copyright © 2018 WallaCorp. All rights reserved.
//

import Foundation

protocol GameDetailsInteractorInput {
    var presenter: GameDetailsInteractorOutput? { get set }
    
    init(withGame game: GameModel)
    func getGame() -> GameModel
    func toggleFavoriteStatus()
}

protocol GameDetailsInteractorOutput {
    func gameFavoriteStatusChanged()
}
