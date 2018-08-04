//
//  File.swift
//  Farfetch Challenge
//
//  Created by Wallace Souza Silva on 31/07/18.
//  Copyright © 2018 WallaCorp. All rights reserved.
//

import Foundation
import UIKit

protocol GameDetailsRouterInterface {
    
}

class GameDetailsRouter {
    static func createModule(withGame game: GameModel) -> UIViewController {
        // Generating module components
        var view: GameDetailsViewInterface = GameDetailsViewController()
        var presenter: GameDetailsPresenterInterface & GameDetailsInteractorOutput = GameDetailsPresenter()
        var interactor: GameDetailsInteractorInput = GameDetailsInteractor(withGame: game)
        let wireFrame: GameDetailsRouterInterface = GameDetailsRouter()
        
        // Connecting
        view.presenter = presenter
        presenter.view = view
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view as! UIViewController
    }
}

extension GameDetailsRouter: GameDetailsRouterInterface {
    
}

