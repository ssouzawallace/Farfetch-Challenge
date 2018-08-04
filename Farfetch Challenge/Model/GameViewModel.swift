//
//  GameViewModel.swift
//  Farfetch Challenge
//
//  Created by Wallace Souza Silva on 25/07/18.
//  Copyright © 2018 WallaCorp. All rights reserved.
//

import Foundation



class GameViewModel {
    enum ImageType {
        case thumbnail
        case fullImage
    }
    
    private let game: GameModel
    
    init(game: GameModel) {
        self.game = game
    }
    
    var name: String {
        return game.name
    }
    
    var isFavorite: Bool {
        return LocalDataStore.shared.getFavoriteGames().contains(game)
    }
    
    func boxArtUrl(forImageType imageType: ImageType) -> String {
        switch imageType {
        case .thumbnail:
            return game.boxArtThumbnailUrl
        case .fullImage:
            return game.boxFullArtUrl
        }
    }
}
