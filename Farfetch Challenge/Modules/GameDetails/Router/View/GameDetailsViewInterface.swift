//
//  GameDetailsViewInterface.swift
//  Farfetch Challenge
//
//  Created by Wallace Souza Silva on 02/08/18.
//  Copyright © 2018 WallaCorp. All rights reserved.
//

import Foundation

protocol GameDetailsViewInterface: GameDisplayableView {
    var presenter: GameDetailsPresenterInterface? { get set }
    
}
