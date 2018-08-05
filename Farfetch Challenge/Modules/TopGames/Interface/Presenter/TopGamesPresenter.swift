//
//  TopGamesPresenter.swift
//  Farfetch Challenge
//
//  Created by Wallace Souza Silva on 31/07/18.
//  Copyright © 2018 WallaCorp. All rights reserved.
//

import Foundation

class TopGamesPresenter {
    
    var view: TopGamesViewInterface?
    var interactor: TopGamesInteractorInput?
    var router: TopGamesRouterInterface?
    
    var gamesList: [GameModel] = []
}

extension TopGamesPresenter: TopGamesPresenterInterface {
    
    func start() {
        view?.showLoader()
        view?.hideNoInternetMessage()
        interactor?.fetchFromBegining()
    }
    
    var numberOfGames: Int {
        return gamesList.count
    }
    
    func configure(view: GameDisplayableView, at index: Int) {
        let gameViewModel = GameViewModel(game: gamesList[index])
        view.configureWith(game: gameViewModel)
    }
    
    func favoriteButtonTapped(at index: Int) {
        interactor?.toggleFavorite(forGame: gamesList[index])
    }
    
    func didSelectGame(at index: Int) {
        router?.showDetails(ofGame: gamesList[index])
    }
    
    func listIsReachingEnd() {
        askNewPageIfPossible()
    }
    
    private func askNewPageIfPossible() {
        interactor?.fetchNextPage()
    }
}

extension TopGamesPresenter: TopGamesInteractorOutput {
    
    func fetched(gamesList: [GameModel]) {
        self.gamesList = gamesList
        view?.hideLoader()
        view?.hideNoInternetMessage()
        view?.reloadGames()
    }
    
    func noInternet() {
        view?.hideLoader()
        view?.showNoInternetMessage()
    }
}
