//
//  FavoriteGamesInterface.swift
//  Farfetch Challenge
//
//  Created by Wallace Souza Silva on 01/08/18.
//  Copyright © 2018 WallaCorp. All rights reserved.
//

import Foundation

protocol FavoriteGamesViewInterface {
    
    var presenter: FavoriteGamesPresenterInterface? { get set }
    
    func updateIndices(toInsertIndexes: [Int], toDeleteIndexes: [Int])
    func reloadGames()
}
