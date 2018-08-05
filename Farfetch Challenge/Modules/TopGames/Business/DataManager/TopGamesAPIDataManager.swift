//
//  TopGamesAPIDataManager.swift
//  Farfetch Challenge
//
//  Created by Wallace Souza Silva on 05/08/18.
//  Copyright © 2018 WallaCorp. All rights reserved.
//

import Foundation

class TopGamesAPIDataManager: TopGamesAPIDataManagerInterface {
    let twitchClient = TwitchClient()
    
    func fetchPage(after cursor: String?, completion: @escaping (Result<GameFeedResult, APIError>) -> Void) {
        twitchClient.fetchPage(after: cursor)  { result in
            completion(result)
        }
    }
}
