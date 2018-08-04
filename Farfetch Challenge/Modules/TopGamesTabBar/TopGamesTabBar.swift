//
//  TopGamesTabBar.swift
//  Farfetch Challenge
//
//  Created by Wallace Souza Silva on 01/08/18.
//  Copyright © 2018 WallaCorp. All rights reserved.
//

import Foundation
import UIKit

class TopGamesTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let topGames = TopGamesRouter.createModule()
        
        let favoriteGames = FavoriteGamesRouter.createModule()
        
        let topGamesNavigation = UINavigationController(rootViewController: topGames)
        topGamesNavigation.tabBarItem.title = topGames.title
        let favoriteGamesNavigation = UINavigationController(rootViewController: favoriteGames)
        favoriteGamesNavigation.tabBarItem.title = favoriteGamesNavigation.title
        let tabs = [topGamesNavigation,
                    favoriteGamesNavigation]
        setViewControllers(tabs, animated: false)
    }
}
