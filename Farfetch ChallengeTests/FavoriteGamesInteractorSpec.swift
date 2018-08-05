//
//  FavoriteGamesInteractorSpec.swift
//  Farfetch ChallengeTests
//
//  Created by Wallace Souza Silva on 05/08/18.
//  Copyright © 2018 WallaCorp. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import Farfetch_Challenge

final class FavoriteGamesInteractorSpec: QuickSpec {
    private class PresenterMock: FavoriteGamesInteractorOutput {
        var receivedGames: [GameModel] = []
        
        func favoriteGamesChanged(_ games: [GameModel]) {
            receivedGames = games
        }
    }
    
    private class LocalDataManagerMock: FavoriteGamesLocalDataManagerInterface {
        var favoriteGames: [GameModel] = []
        
        var favoriteGamesChangedCallback: (() -> Void)?
        
        init() {
            do {
                let gameFeedResult = try JSONDecoder().decode(GameFeedResult.self, from: feedResultData())
                favoriteGames = gameFeedResult.games
            } catch {
                print("ERROR: Erro ao tentar recuperar mocked gameFeedResult\n\(error)")
            }
        }
        
        func getFavoriteGames() -> [GameModel] {
            return favoriteGames
        }
        
        func toggleFavorite(_ game: GameModel) {
            if let index = favoriteGames.index(of: game) {
                favoriteGames.remove(at: index)
            } else {
                favoriteGames.append(game)
            }
            favoriteGamesChangedCallback?()
        }
    }

    override func spec() {
        var sut: FavoriteGamesInteractor!
        var presenterMock: PresenterMock!
        var localDataManager: LocalDataManagerMock!
        
        beforeEach {
            sut = FavoriteGamesInteractor()
            presenterMock = PresenterMock()
            localDataManager = LocalDataManagerMock()
            sut.presenter = presenterMock
            sut.localDataManager = localDataManager
            localDataManager.favoriteGamesChangedCallback = sut.favoriteGamesChanged
        }
        
        afterEach {
        }
        
        context("should get games from remote local storage") {
            beforeEach {
                sut.fetchFavorites()
            }
            it("check if presenter received games list") {
                expect(presenterMock.receivedGames.count).to(beGreaterThan(0))
            }
        }
        
        context("should add and remove favorite") {
            beforeEach {
                sut.fetchFavorites()
            }
            
            it("check game addition") {
                let previousCount = presenterMock.receivedGames.count
                let firstGame = presenterMock.receivedGames[0]
                sut.toggleFavorite(forGame: firstGame)
                expect(presenterMock.receivedGames.count).to(equal(previousCount-1))
            }
            
            it("check game deletion") {
                let previousCount = presenterMock.receivedGames.count
                let firstGame = presenterMock.receivedGames[0]
                sut.toggleFavorite(forGame: firstGame)
                sut.toggleFavorite(forGame: firstGame)
                expect(presenterMock.receivedGames.count).to(equal(previousCount))
            }
        }
    }
}
