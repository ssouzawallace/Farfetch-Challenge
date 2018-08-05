//
//  FavoriteGamesPresenter.swift
//  Farfetch Challenge
//
//  Created by Wallace Souza Silva on 02/08/18.
//  Copyright © 2018 WallaCorp. All rights reserved.
//

import Foundation
import PHDiff

class FavoriteGamesPresenter {
    var view: FavoriteGamesViewInterface?
    var interactor: FavoriteGamesInteractorInput?
    var router: FavoriteGamesRouterInterface?
    
    var favoriteGames: [GameModel] = []
}

extension FavoriteGamesPresenter: FavoriteGamesPresenterInterface {
    func viewDidLoad() {
        interactor?.fetchFavorites()
//        view?.reloadGames()
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
        if games.count == 0 {
            view?.showEmptyState()
        } else {
            view?.hideEmptyState()
        }
        
        updateIndices(for: games)
        
    }
    
    private func updateIndices(for gamesList: [GameModel]) {
        let steps = PHDiff.steps(fromArray: favoriteGames, toArray: gamesList)
        
        if steps.count > 0 {
            
            
            var insertions: [Int] = []
            var deletions: [Int] = []
            var reloads: [Int] = []
            
            steps.forEach { step in
                switch step {
                case let .insert(_, index):
                    insertions.append(index)
                case let .delete(_, index):
                    deletions.append(index)
                case let .move(_, fromIndex, toIndex):
                    deletions.append(fromIndex)
                    insertions.append(toIndex)
                case let .update(_, index):
                    reloads.append(index)
                }
            }
            
//            favoriteGames = gamesList
            view?.reloadGamesWith(games: gamesList,
                                  insertedIndices: insertions,
                                  deletedIndices: deletions,
                                  movedIndices: [])
        }
        
//        let before = favoriteGames
//        let after = gamesList
//
//        var insertedIndices : [Int] = []
//        var deletedIndices : [Int] = []
//        var movedIndices : [(from: Int, to: Int)] = []
//
//        var map : [ String : (from: Int, to: Int)] = [:]
//
//        // Add [ id : (from, -1) ] for each id in before:
//        for (idx, elem) in before.enumerated() {
//            map[elem.id] = (from: idx, to: -1)
//        }
//
//        // Update [ id : (from, to) ] or add [ id : (-1, to) ] for each id in after:
//        for (idx, elem) in after.enumerated() {
//            if (map[elem.id]?.to = idx) == nil {
//                map[elem.id] = (from: -1, to: idx)
//            }
//        }
//
//        // Compare from: and to: index for each dictionary value:
//        for pair in map.values {
//            switch pair {
//            case (let fromIdx, -1):
//                deletedIndices.append(fromIdx)
//            case (-1, let toIdx):
//                insertedIndices.append(toIdx)
//            default:
//                movedIndices.append(pair)
//            }
//        }
//        favoriteGames = gamesList
//        view?.reloadGamesWith(insertedIndices: insertedIndices,
//                              deletedIndices: deletedIndices,
//                              movedIndices: movedIndices)
    }
}


