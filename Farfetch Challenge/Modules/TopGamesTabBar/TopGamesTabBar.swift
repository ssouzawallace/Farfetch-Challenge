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
        topGamesNavigation.tabBarItem.selectedImage = UIImage(named: "joystick_barIcon_filled")
        topGamesNavigation.tabBarItem.image = UIImage(named: "joystick_barIcon_outline")
        
        let favoriteGamesNavigation = UINavigationController(rootViewController: favoriteGames)
        favoriteGamesNavigation.tabBarItem.selectedImage = UIImage(named: "heart_barIcon_filled")
        favoriteGamesNavigation.tabBarItem.image = UIImage(named: "heart_barIcon_outline")
        
        let tabs = [topGamesNavigation,
                    favoriteGamesNavigation]
        setViewControllers(tabs, animated: false)
    }
}
