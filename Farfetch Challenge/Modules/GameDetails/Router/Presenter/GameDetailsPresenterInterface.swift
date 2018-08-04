//
//  GameDetailsPresenterInterface.swift
//  Farfetch Challenge
//
//  Created by Wallace Souza Silva on 02/08/18.
//  Copyright © 2018 WallaCorp. All rights reserved.
//

import Foundation

protocol GameDetailsPresenterInterface {
    var view: GameDetailsViewInterface? { get set }
    var interactor: GameDetailsInteractorInput? { get set }
    var wireFrame: GameDetailsRouterInterface? { get set }

    func viewDidLoad()
    
    func favoriteButtonTapped()
}
