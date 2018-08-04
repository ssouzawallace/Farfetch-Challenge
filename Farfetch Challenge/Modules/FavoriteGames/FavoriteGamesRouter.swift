//
//  FavoriteGamesRouter.swift
//  Farfetch Challenge
//
//  Created by Wallace Souza Silva on 01/08/18.
//  Copyright © 2018 WallaCorp. All rights reserved.
//

import Foundation
import UIKit

class FavoriteGamesRouterInterface {
}

class FavoriteGamesRouter: FavoriteGamesRouterInterface {
    class func createModule() -> UIViewController {
        // Generating module components
        var view: FavoriteGamesViewInterface = FavoriteGamesViewController()
        var presenter: FavoriteGamesPresenterInterface & FavoriteGamesInteractorOutput = FavoriteGamesPresenter()
        var interactor: FavoriteGamesInteractorInput = FavoriteGamesInteractor()
        let wireFrame: FavoriteGamesRouterInterface = FavoriteGamesRouter()
        
        // Connecting
        view.presenter = presenter
        presenter.view = view
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view as! UIViewController
    }
}
