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
    
    var favoriteGames: [GameModel] = []
}

extension TopGamesPresenter: TopGamesPresenterInterface {
    
    func start() {
        view?.showLoader()
        view?.hideNoInternetMessage()
        askNewPageIfPossible()
    }
    
    var numberOfGames: Int {
        return favoriteGames.count
    }
    
    func configure(view: GameDisplayableView, at index: Int) {
        let gameViewModel = GameViewModel(game: favoriteGames[index])
        view.configureWith(game: gameViewModel)
    }
    
    func favoriteButtonTapped(at index: Int) {
        interactor?.toggleFavorite(forGame: favoriteGames[index])
    }
    
    func didSelectGame(at index: Int) {
        router?.showDetails(ofGame: favoriteGames[index])
    }
    
    func listIsReachingEnd() {
        askNewPageIfPossible()
    }
    
    private func askNewPageIfPossible() {
//        guard interactor?.currentPage.state != .loading else {
//            return
//        }
        interactor?.fetchNextPage()
    }
}

extension TopGamesPresenter: TopGamesInteractorOutput {
    
    func fetched(gamesList: [GameModel]) {
        favoriteGames = gamesList
        view?.hideLoader()
        view?.hideNoInternetMessage()
        view?.reloadGames()
    }
    
    func noInternet() {
        view?.hideLoader()
        view?.showNoInternetMessage()
    }
}
