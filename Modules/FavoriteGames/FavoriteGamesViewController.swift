//
//  FavoriteGamesViewController.swift
//  Farfetch Challenge
//
//  Created by Wallace Souza Silva on 24/07/18.
//  Copyright © 2018 WallaCorp. All rights reserved.
//

import Foundation
import UIKit

class FavoriteGamesViewController: UIViewController {
    var gameListRenderer: GameListRenderer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchGameListRenderer()
    }
    private func fetchGameListRenderer() {
        if let renderer = childViewControllers.filter({
            return $0 is GameListRenderer
        }).first as? GameListRenderer {
            gameListRenderer = renderer
            gameListRenderer?.delegate = self
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        LocalData.sharedInstance.fetchFavoriteGames { gameList in
            self.gameListRenderer?.render(games: gameList)
        }
    }
}

extension FavoriteGamesViewController: GameListDelegate {
    func listIsReachingEnd() {
        // TODO: ask next page
    }
}
