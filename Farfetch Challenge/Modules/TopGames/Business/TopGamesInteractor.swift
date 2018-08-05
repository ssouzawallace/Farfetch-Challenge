//
//  TopGamesInteractor.swift
//  Farfetch Challenge
//
//  Created by Wallace Souza Silva on 31/07/18.
//  Copyright © 2018 WallaCorp. All rights reserved.
//

import Foundation

struct Page {
    enum State {
        case unloaded
        case loading
        case loaded
    }
    let state: State
    let cursor: String?
}

class TopGamesInteractor {
    
    var presenter: TopGamesInteractorOutput?
    var apiDataManager: TopGamesAPIDataManagerInterface?
    
    let twitchClient = TwitchClient()
    var currentPage: Page = Page(state: .unloaded, cursor: nil)
    var games: [GameModel] = []
    
    init() {
        LocalDataStore.shared.subscribe(self)
    }
    
    deinit {
        LocalDataStore.shared.unsubscribe(self)
    }
}

extension TopGamesInteractor: TopGamesInteractorInput {
    
    func fetchFromBegining() {
        currentPage = Page(state: .unloaded, cursor: nil)
        games = []
        fetchNextPage()
    }
    
    func fetchNextPage() {
        guard currentPage.state != .loading else {
            return
        }
        currentPage = Page(state: .loading, cursor: currentPage.cursor)
        apiDataManager?.fetchPage(after: currentPage.cursor) { [weak self] result in
            switch result {
            case .success(let gameFeedResult):
                self?.games += gameFeedResult.games
                self?.currentPage = Page(state: .loaded, cursor: gameFeedResult.pageCursor)
                if let games  = self?.games {
                    self?.presenter?.fetched(gamesList: games)
                }
                
                break
            case .failure(let error):                
                if error == .notConnected {
                    self?.currentPage = Page(state: .unloaded, cursor: nil)
                    self?.presenter?.noInternet()
                }
                print(error)
                break
            }
        }
    }
    
    func toggleFavorite(forGame game: GameModel) {
        if LocalDataStore.shared.isFavorite(game: game) {
            LocalDataStore.shared.removeFavorite(game: game)
        } else {
            LocalDataStore.shared.addFavorite(game: game)
        }
    }
}

extension TopGamesInteractor: FavoriteGamesStoreSubscriber {
    func favoriteGamesChanged() {
        if games.count > 0 {
            presenter?.fetched(gamesList: games)
        }        
    }
}
