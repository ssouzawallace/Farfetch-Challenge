//
//  GameFeedResult.swift
//  Farfetch Challenge
//
//  Created by Wallace Souza Silva on 25/07/18.
//  Copyright © 2018 WallaCorp. All rights reserved.
//

import Foundation
import Unbox

struct GameFeedResult {
    let games: [GameModel]
    let pageCursor: String
}

extension GameFeedResult: Unboxable {
    init(unboxer: Unboxer) throws {
        self.games = try unboxer.unbox(key: "data")
        self.pageCursor = try unboxer.unbox(keyPath: "pagination.cursor")
    }
}
