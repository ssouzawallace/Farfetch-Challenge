//
//  GameModel.swift
//  Farfetch Challenge
//
//  Created by Wallace Souza Silva on 24/07/18.
//  Copyright © 2018 WallaCorp. All rights reserved.
//

import Foundation

public struct GameModel: Codable {
    enum GameCodingKey: String, CodingKey {
        case id
        case name
        case boxArtUrlTemplate = "box_art_url"
    }
    
    let id: String
    let name: String
    let boxArtUrlTemplate: String
    
    var boxArtThumbnailUrl: String {
        return boxArtUrlWith(width: Constants.thumbnailImageWidth,
                                    height: Constants.thumbnailImageHeight)
    }
    
    var boxFullArtUrl: String {
        return boxArtUrlWith(width: Constants.fullImageWidth,
                             height: Constants.fullImageHeight)
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: GameCodingKey.self)
        
        id = try values.decode(String.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        boxArtUrlTemplate = try values.decode(String.self, forKey: .boxArtUrlTemplate)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: GameCodingKey.self)
        
        try container.encode(name, forKey: .name)
        try container.encode(id, forKey: .id)
        try container.encode(boxArtUrlTemplate, forKey: .boxArtUrlTemplate)
    }
    
    private func boxArtUrlWith(width: Int, height: Int) -> String {
        return boxArtUrlTemplate
            .replacingOccurrences(of: "{width}",
                                  with: width.description)
            .replacingOccurrences(of: "{height}",
                                  with: height.description)
    }
}

extension GameModel: Equatable {
    public static func == (lhs: GameModel, rhs: GameModel) -> Bool {
        return lhs.id == rhs.id
    }
}
