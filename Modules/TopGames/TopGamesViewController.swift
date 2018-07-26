//
//  TopGamesViewController.swift
//  Farfetch Challenge
//
//  Created by Wallace Souza Silva on 24/07/18.
//  Copyright © 2018 WallaCorp. All rights reserved.
//

import Foundation
import UIKit

class TopGamesViewController: UIViewController {
    var gameListRenderer: GameListRenderer?
    
    let twitchClient = TwitchClient()
    
    var games: [GameModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchGameListRenderer()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        fetchNextPage()
    }
    func fetchNextPage() {
        guard twitchClient.state == .ready else {
            return
        }
        twitchClient.fetchNextPage { result in
            switch result {
            case .success(let gameFeedResult):
                // TODO: fix force unwrap
                self.games += gameFeedResult!.games
                self.gameListRenderer?.render(games: self.games)
                break
            case .failure(let error):
                // TODO: handle error
                break
            }
        }
    }

    private func fetchGameListRenderer() {
        if let renderer = childViewControllers.filter({
            return $0 is GameListRenderer
        }).first as? GameListRenderer {
            gameListRenderer = renderer
            gameListRenderer?.delegate = self
        }
    }
}

extension TopGamesViewController: GameListDelegate {
    func listIsReachingEnd() {
        fetchNextPage()
    }
}
