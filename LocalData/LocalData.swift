//
//  LocalData.swift
//  Farfetch Challenge
//
//  Created by Wallace Souza Silva on 24/07/18.
//  Copyright © 2018 WallaCorp. All rights reserved.
//

import Foundation

//enum GamesListSource {
//    case top
//    case favorites
//}
//
//protocol GamesFetcher {
//    func fetch(source: GamesListSource)
//}
//
//protocol FavoriteGamesFetcher: GamesFetcher {
//
//}
//
//protocol TopGamesFetcher: GamesFetcher {
//    func fetchNext()
//}

typealias GameListClosure = ([GameModel]) -> Void

class LocalData {
    
    static let sharedInstance: LocalData = LocalData()
    
    private init() {
        // Preventing class to be instanced elsewhere
    }
    
    var favoriteGames: [GameModel]? = nil
    
    func fetchFavoriteGames(callback: @escaping GameListClosure) {
        if let favoriteGames = self.favoriteGames {
            callback(favoriteGames)
        } else {
            // TODO: fetch from local storage
            let gamesList = [GameModel(id: "33214",
                                       name: "Fortnite",
                                       boxArtUrl: "https://static-cdn.jtvnw.net/ttv-boxart/Fortnite.jpg"),
                             GameModel(id: "494717",
                                       name: "IRL",
                                       boxArtUrl: "https://static-cdn.jtvnw.net/ttv-boxart/IRL.jpg"),
                             GameModel(id: "18122",
                                       name: "World of Warcraft",
                                       boxArtUrl: "https://static-cdn.jtvnw.net/ttv-boxart/World%20of%20Warcraft.jpg"),
                             GameModel(id: "32982",
                                       name: "Grand Theft Auto V",
                                       boxArtUrl: "https://static-cdn.jtvnw.net/ttv-boxart/Grand%20Theft%20Auto%20V.jpg")]
            self.favoriteGames = gamesList
            callback(gamesList)
        }
    }
}
