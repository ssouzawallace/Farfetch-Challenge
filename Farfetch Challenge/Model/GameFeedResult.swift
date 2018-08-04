//
//  GameFeedResult.swift
//  Farfetch Challenge
//
//  Created by Wallace Souza Silva on 25/07/18.
//  Copyright © 2018 WallaCorp. All rights reserved.
//

import Foundation

struct GameFeedResult: Codable {
    enum GameFeedResultCodingKey: String, CodingKey {
        case games = "data"
        case pagination
    }
    
    let games: [GameModel]
    let pageCursor: String
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: GameFeedResultCodingKey.self)
        
        games = try values.decode([GameModel].self, forKey: .games)
        
        if let cursor = try values.decode([String: String].self, forKey: .pagination)["cursor"] {
            pageCursor = cursor
        } else {
            pageCursor = ""
        }
    }
}
