//
//  FavoriteGamesInteractor.swift
//  Farfetch Challenge
//
//  Created by Wallace Souza Silva on 02/08/18.
//  Copyright © 2018 WallaCorp. All rights reserved.
//

import Foundation

class FavoriteGamesInteractor {
    var presenter: FavoriteGamesInteractorOutput?
    
    init() {
        LocalDataStore.shared.subscribe(self)
    }
    
    deinit {
        LocalDataStore.shared.unsubscribe(self)
    }
}

extension FavoriteGamesInteractor: FavoriteGamesInteractorInput {
    func fetchFavorites() {
        presenter?.favoriteGamesChanged(LocalDataStore.shared.getFavoriteGames())
    }
}

extension FavoriteGamesInteractor: FavoriteGamesStoreSubscriber {
    func favoriteGamesChanged() {
        presenter?.favoriteGamesChanged(LocalDataStore.shared.getFavoriteGames())
        // TODO
    }
}
