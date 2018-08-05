//
//  TopGamesInteractorIO.swift
//  Farfetch Challenge
//
//  Created by Wallace Souza Silva on 01/08/18.
//  Copyright © 2018 WallaCorp. All rights reserved.
//

import Foundation

protocol TopGamesInteractorInput {
    var presenter: TopGamesInteractorOutput? { get set }
    
    func toggleFavorite(forGame game: GameModel)
    func fetchFromBegining()
    func fetchNextPage()
}

protocol TopGamesInteractorOutput {
    func fetched(gamesList: [GameModel])
    func noInternet()
}
