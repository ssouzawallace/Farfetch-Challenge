//
//  GameDetailsInteractorSpec.swift
//  Farfetch Challenge
//
//  Created by Wallace Souza Silva on 05/08/18.
//  Copyright © 2018 WallaCorp. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import Farfetch_Challenge

final class GameDetailsInteractorSpec: QuickSpec {

    private class PresenterMock: GameDetailsInteractorOutput {
        var favoriteStatusChangedCalled = false
        
        func gameFavoriteStatusChanged() {
            favoriteStatusChangedCalled = true
        }
    }
    
    override func spec() {
        var sut: GameDetailsInteractor!
        var presenterMock: PresenterMock!
        
        let game = GameModel(id: "33214",
                             name: "Fortnite",
                             boxArtUrlTemplate: "https://static-cdn.jtvnw.net/ttv-boxart/Fortnite-{width}x{height}.jpg")
        
        beforeEach {
            sut = GameDetailsInteractor(withGame: game)
            presenterMock = PresenterMock()
            sut.presenter = presenterMock
        }
        
        afterEach {
        }
        
        context("should retrieve correct game") {
            it("check current game") {
                expect(sut.getGame()).to(equal(game))
            }
        }
        
        context("changing favorite status") {
            beforeEach {
                sut.toggleFavoriteStatus()
            }
            
            it("check current game") {
                expect(presenterMock.favoriteStatusChangedCalled).to(be(true))
            }
        }
    }
}
