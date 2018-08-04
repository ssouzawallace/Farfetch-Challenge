//
//  FavoriteGamesStoreImplementation.swift
//  Farfetch Challenge
//
//  Created by Wallace Souza Silva on 03/08/18.
//  Copyright © 2018 WallaCorp. All rights reserved.
//

import Foundation
import SDWebImage

class LocalDataStore {
    
    // MARK: - Public API
    
    static let shared = LocalDataStore()
    
    func subscribe(_ subscriber: FavoriteGamesStoreSubscriber) {
        subscribers.append(subscriber)
    }
    
    func unsubscribe(_ subscriber: FavoriteGamesStoreSubscriber) {
        if let index = subscribers.index(where: { return $0 === subscriber }) {
            subscribers.remove(at: index)
        }
    }
    
    func addFavorite(game: GameModel) {
        favoriteGames.append(game)
        storeFavoriteGames(favoriteGames)
        broadcastFavoriteGamesChanged()
    }
    func removeFavorite(game: GameModel) {
        if let index = favoriteGames.index(of: game) {
            let game = favoriteGames[index]
            removePictures(ofGame: game)
            favoriteGames.remove(at: index)
            storeFavoriteGames(favoriteGames)
            broadcastFavoriteGamesChanged()
        }
    }
    
    func getFavoriteGames() -> [GameModel] {
        return favoriteGames
    }
    
    func isFavorite(game: GameModel) -> Bool {
        return getFavoriteGames().contains(game)
    }
    
    // MARK: - Private
    
    private var subscribers: [FavoriteGamesStoreSubscriber] = []
    
    private var favoriteGames: [GameModel] = [] {
        didSet {
            self.broadcastFavoriteGamesChanged()
        }
    }
    
    private init () {
        loadFavoriteGames()
    }
    
    private enum ImageSize: String {
        case thumbnail
        case fullSize
    }
    
    private func broadcastFavoriteGamesChanged() {
        subscribers.forEach {
            $0.favoriteGamesChanged()
        }
    }

    private func loadFavoriteGames() {
        guard let favoriteGamesData = UserDefaults.standard.value(forKey: favoriteListKey()) as? Data else {
            return
        }
        do {
            let favoriteGames = try JSONDecoder().decode([GameModel].self, from: favoriteGamesData)
            self.favoriteGames = favoriteGames
            retrieveImagesToCache(favoriteGames)
        } catch {
            print("ERRO: Falha ao recuperar lista de favoritos\n\(error)")
        }
    }
    
    private func removePictures(ofGame game: GameModel) {
        UserDefaults.standard.removeObject(forKey: keyFor(gameId: game.id, size: .thumbnail))
        UserDefaults.standard.removeObject(forKey: keyFor(gameId: game.id, size: .fullSize))
    }
    
    private func storeFavoriteGames(_ favoriteGames: [GameModel]) {
        do {
            let jsonData = try JSONEncoder().encode(favoriteGames as [GameModel])
            UserDefaults.standard.set(jsonData, forKey: favoriteListKey())
            
            for favoriteGame in favoriteGames {
                fetchAndSaveImage(withUrlString: favoriteGame.boxArtThumbnailUrl, usingKey: keyFor(gameId: favoriteGame.id, size: .thumbnail))
                fetchAndSaveImage(withUrlString: favoriteGame.boxFullArtUrl, usingKey: keyFor(gameId: favoriteGame.id, size: .fullSize))
            }
        } catch {
            print("ERRO: Falha ao salvar lista de favoritos\n\(error)")
        }
    }
    
    private func fetchAndSaveImage(withUrlString urlString: String, usingKey key: String) {
        SDWebImageManager.shared().loadImage(with: URL(string: urlString),
                                             options: [.continueInBackground, .highPriority],
                                             progress: nil,
                                             completed: { image, data, error, cacheType, finished, url in
                                                if finished && error == nil && data != nil {
                                                    UserDefaults.standard.set(data, forKey: key)
                                                }
        })
    }
    
    private func retrieveImagesToCache(_ favoriteGames: [GameModel]) {
        for favoriteGame in favoriteGames {
            guard let thumbnailImageData = UserDefaults.standard.value(forKey: keyFor(gameId: favoriteGame.id, size: .thumbnail)) as? Data else {
                return
            }
            guard let fullSizeImageData = UserDefaults.standard.value(forKey: keyFor(gameId: favoriteGame.id, size: .fullSize)) as? Data else {
                return
            }
            
            let thumbnailImage = UIImage(data: thumbnailImageData)
            let fullSizeImage = UIImage(data: fullSizeImageData)
            
            SDWebImageManager.shared().saveImage(toCache: thumbnailImage, for: URL(string: favoriteGame.boxArtThumbnailUrl))
            SDWebImageManager.shared().saveImage(toCache: fullSizeImage, for: URL(string: favoriteGame.boxFullArtUrl))
        }
    }
    
    private func favoriteListKey() ->  String {
        return "LocalDataStore.favoriteGames"
    }
    
    private func keyFor(gameId: String, size: ImageSize) -> String {
        return "\(gameId).thumbnail"
    }
}
