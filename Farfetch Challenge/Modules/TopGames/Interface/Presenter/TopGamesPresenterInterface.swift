//
//  TopGamesPresenterInterface.swift
//  Farfetch Challenge
//
//  Created by Wallace Souza Silva on 01/08/18.
//  Copyright © 2018 WallaCorp. All rights reserved.
//

import Foundation

protocol GameDisplayableView {
    func configureWith(game: GameViewModel)
}

protocol TopGamesPresenterInterface {
    var view: TopGamesViewInterface? { get set }
    var interactor: TopGamesInteractorInput? { get set }
    var router: TopGamesRouterInterface? { get set }
    
    func viewDidLoad()
    
    var numberOfGames: Int { get }
    
    func listIsReachingEnd()    
    func configure(view: GameDisplayableView, at index: Int)
    func favoriteButtonTapped(at index: Int)
    func didSelectGame(at index: Int)
}
