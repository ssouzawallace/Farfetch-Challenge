//
//  FavoriteGamesStoreRedux.swift
//  Farfetch Challenge
//
//  Created by Wallace Souza Silva on 31/07/18.
//  Copyright © 2018 WallaCorp. All rights reserved.
//

import Foundation
import ReSwift

//class FavoriteGamesStoreRedux: FavoriteGamesStore {
//    
////    let local = LocalDataStore()
//    
//    var subscribers: [FavoriteGamesStoreSubscriber] = []
//    
//    var games: [GameModel] = []
//    
//    init() {
////        local.loadFavoriteGames { favoriteGames in
////            self.games = favoriteGames
////            self.newState(state: AppState())
////        }
//        mainStore.subscribe(self)
//    }
//    
//    deinit {
//        mainStore.unsubscribe(self)
//    }
//    
//    func subscribe(_ subscriber: FavoriteGamesStoreSubscriber) {
//        subscribers.append(subscriber)
//    }
//    
//    func unsubscribe(_ subscriber: FavoriteGamesStoreSubscriber) {
//        
//    }
//    
//    func addFavorite(game: GameModel) {
//        mainStore.dispatch(FavoriteGamesActionAdd(game: game))
//        games.append(game)
////        local.storeFavoriteGames(games)
//    }
//    func removeFavorite(game: GameModel) {
//        mainStore.dispatch(FavoriteGamesActionRemove(game: game))
//        if let index = games.index(of: game) {
//            games.remove(at: index)
//        }
//    }
//    
//    func retrieveFavoriteGames() -> [GameModel] {
//        return games
//    }
//    
//    func isFavorite(game: GameModel) -> Bool {
//        return retrieveFavoriteGames().contains(game)
//    }
//}
//
//
//extension FavoriteGamesStoreRedux: StoreSubscriber {
//    func newState(state: AppState) {
//        subscribers.forEach {
//            $0.favoriteGamesChanged()
//        }
//    }
//}
