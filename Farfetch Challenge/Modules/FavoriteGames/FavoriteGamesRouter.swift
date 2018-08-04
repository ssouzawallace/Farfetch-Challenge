//
//  FavoriteGamesRouter.swift
//  Farfetch Challenge
//
//  Created by Wallace Souza Silva on 01/08/18.
//  Copyright © 2018 WallaCorp. All rights reserved.
//

import Foundation
import UIKit

protocol FavoriteGamesRouterInterface {
    func showDetails(ofGame game: GameModel)
}

class FavoriteGamesRouter {
    
    let view: UIViewController
    
    init(view: UIViewController) {
        self.view = view
    }
    
    class func createModule() -> UIViewController {
        // Generating module components
        var view: FavoriteGamesViewInterface = FavoriteGamesViewController()
        var presenter: FavoriteGamesPresenterInterface & FavoriteGamesInteractorOutput = FavoriteGamesPresenter()
        var interactor: FavoriteGamesInteractorInput = FavoriteGamesInteractor()
        let router: FavoriteGamesRouterInterface = FavoriteGamesRouter(view: view as! UIViewController)
        
        // Connecting
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view as! UIViewController
    }
}

extension FavoriteGamesRouter: FavoriteGamesRouterInterface {
    func showDetails(ofGame game: GameModel) {
        let detailsViewController = GameDetailsRouter.createModule(withGame: game)
        detailsViewController.hidesBottomBarWhenPushed = true
        view.navigationController?.show(detailsViewController, sender: self)
    }
}
