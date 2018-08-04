//
//  GameModel.swift
//  Farfetch Challenge
//
//  Created by Wallace Souza Silva on 24/07/18.
//  Copyright © 2018 WallaCorp. All rights reserved.
//

import Foundation
import Unbox

public struct GameModel: Codable {
    let id: String
    let name: String
    let boxArtThumbnailUrl: String
    let boxFullArtUrl: String
}

extension GameModel: Equatable {
    public static func == (lhs: GameModel, rhs: GameModel) -> Bool {
        return lhs.id == rhs.id
    }
}

extension GameModel: Unboxable {
    public init(unboxer: Unboxer) throws {
        self.id = try unboxer.unbox(keyPath: "id")
        self.name = try unboxer.unbox(keyPath: "name")
        let boxArtUrlTemplate: String = try unboxer.unbox(keyPath: "box_art_url")
        self.boxArtThumbnailUrl = boxArtUrlTemplate
            .replacingOccurrences(of: "{width}",
                                  with: Constants.thumbnailImageWidth.description)
            .replacingOccurrences(of: "{height}",
                                  with: Constants.thumbnailImageHeight.description)
        self.boxFullArtUrl = boxArtUrlTemplate
            .replacingOccurrences(of: "{width}",
                                  with: Constants.fullImageWidth.description)
            .replacingOccurrences(of: "{height}",
                                  with: Constants.fullImageHeight.description)
    }
}
