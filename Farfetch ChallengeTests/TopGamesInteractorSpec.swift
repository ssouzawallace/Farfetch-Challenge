//
//  TopGamesInteractorSpec.swift
//  Farfetch ChallengeTests
//
//  Created by Wallace Souza Silva on 05/08/18.
//  Copyright © 2018 WallaCorp. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import Farfetch_Challenge

final class TopGamesInteractorSpec: QuickSpec {
    
    private class PresenterMock: TopGamesInteractorOutput {
        var connectedToTheInternet = true
        var receivedData = false
        
        func fetched(gamesList: [GameModel]) {
            receivedData = gamesList.count > 0
        }
        
        func noInternet() {
            connectedToTheInternet = false
        }
    }
    
    private class APIDataManagerMock: TopGamesAPIDataManagerInterface {
        var error = false
        
        func fetchPage(after cursor: String?, completion: @escaping (Result<GameFeedResult, APIError>) -> Void) {
            if error {
                completion(.failure(.notConnected))
            } else {
                do {
                    let gameFeedResult = try JSONDecoder().decode(GameFeedResult.self, from: feedResultData())                    
                    completion(.success(gameFeedResult))
                } catch {
                    print("ERROR: Erro ao tentar recuperar mocked gameFeedResult\n\(error)")
                }
            }
        }
        
    }
    
    override func spec() {
        var sut: TopGamesInteractor!
        var presenterMock: PresenterMock!
        var apiDataManager: APIDataManagerMock!
        
        beforeEach {
            sut = TopGamesInteractor()
            presenterMock = PresenterMock()
            apiDataManager = APIDataManagerMock()
            sut.presenter = presenterMock
            sut.apiDataManager = apiDataManager
        }
        
        afterEach {
        }
        
        context("should get games from remote api") {
            beforeEach {
                apiDataManager.error = false
                sut.fetchFromBegining()
            }
            it("check if presenter received games list") {
                expect(sut.games.count).to(beGreaterThan(0))
                expect(presenterMock.receivedData).to(be(true))
            }
        }
        
        context("should warn error in case of no connection") {
            beforeEach {
                apiDataManager.error = true
                sut.fetchFromBegining()
            }

            it("check if presenter received warning") {
                expect(presenterMock.connectedToTheInternet).to(equal(false))
            }
        }
    }

}
