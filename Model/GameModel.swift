//
//  GameModel.swift
//  Farfetch Challenge
//
//  Created by Wallace Souza Silva on 24/07/18.
//  Copyright © 2018 WallaCorp. All rights reserved.
//

import Foundation
import Unbox

struct GameModel {
    let id: String
    let name: String
    let boxArtUrl: String
}

extension GameModel: Unboxable {
    init(unboxer: Unboxer) throws {
        self.id = try unboxer.unbox(keyPath: "id")
        self.name = try unboxer.unbox(keyPath: "name")
        self.boxArtUrl = try unboxer.unbox(keyPath: "box_art_url")
    }
}
