//
//  FavoriteGamesPresenterInterface.swift
//  Farfetch Challenge
//
//  Created by Wallace Souza Silva on 01/08/18.
//  Copyright © 2018 WallaCorp. All rights reserved.
//

import Foundation

protocol FavoriteGamesPresenterInterface {
    var view: FavoriteGamesViewInterface? { get set }
    var interactor: FavoriteGamesInteractorInput? { get set }
    var router: FavoriteGamesRouterInterface? { get set }
        
    func viewDidLoad()
    
    var numberOfGames: Int { get }
    
    func configure(view: GameDisplayableView, at index: Int)
    func favoriteButtonTapped(at index: Int)
    func didSelectGame(at index: Int)
}
