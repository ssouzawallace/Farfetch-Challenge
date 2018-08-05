//
//  GameDetailsPresenter.swift
//  Farfetch Challenge
//
//  Created by Wallace Souza Silva on 31/07/18.
//  Copyright © 2018 WallaCorp. All rights reserved.
//

import Foundation

class GameDetailsPresenter {
    
    var view: GameDetailsViewInterface?
    var interactor: GameDetailsInteractorInput?
    var wireFrame: GameDetailsRouterInterface?
    
    private func refreshGame() {
        guard let game = interactor?.getGame() else {
            return
        }
        let gameViewModel = GameViewModel(game: game)
        view?.configureWith(game: gameViewModel)
    }
}

extension GameDetailsPresenter: GameDetailsPresenterInterface {
    func viewDidLoad() {
        refreshGame()
    }
    
    func favoriteButtonTapped() {
        interactor?.toggleFavoriteStatus()
    }
}

extension GameDetailsPresenter: GameDetailsInteractorOutput {
    func gameFavoriteStatusChanged() {
        refreshGame()
    }
}
