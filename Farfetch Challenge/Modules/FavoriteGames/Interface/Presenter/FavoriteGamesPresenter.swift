//
//  FavoriteGamesPresenter.swift
//  Farfetch Challenge
//
//  Created by Wallace Souza Silva on 02/08/18.
//  Copyright © 2018 WallaCorp. All rights reserved.
//

import Foundation

class FavoriteGamesPresenter {
    var view: FavoriteGamesViewInterface?
    var interactor: FavoriteGamesInteractorInput?
    var router: FavoriteGamesRouterInterface?
    
    var favoriteGames: [GameModel] = []
}

extension FavoriteGamesPresenter: FavoriteGamesPresenterInterface {
    func viewDidLoad() {
        interactor?.fetchFavorites()
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
}

extension FavoriteGamesPresenter: FavoriteGamesInteractorOutput {
    func favoriteGamesChanged(_ games: [GameModel]) {
        favoriteGames = games
        view?.reloadGames()
//        var currentListIndex = 0
//        var newListIndex = 0
//
//        var toInsertIndexList: [Int] = []
//        var toRemoveIndexList: [Int] = []
//
//        while currentListIndex < favoriteGames.count && newListIndex < games.count {
//            if favoriteGames[currentListIndex] == games[newListIndex] {
//                currentListIndex += 1
//                newListIndex += 1
//            } else {
//                toRemoveIndexList.append(currentListIndex)
//                currentListIndex += 1
//            }
//        }
//        while newListIndex < games.count {
//            toInsertIndexList.append(newListIndex)
//        }
    }
}
