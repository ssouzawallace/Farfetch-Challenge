//
//  TopGamesViewInterface.swift
//  Farfetch Challenge
//
//  Created by Wallace Souza Silva on 01/08/18.
//  Copyright © 2018 WallaCorp. All rights reserved.
//

import Foundation


protocol TopGamesViewInterface {

    var presenter: TopGamesPresenterInterface? { get set }

    func showNoInternetMessage()
    func hideNoInternetMessage()
    func showLoader()
    func hideLoader()
    func reloadGames()
}
