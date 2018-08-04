//
//  TopGamesRouter.swift
//  Farfetch Challenge
//
//  Created by Wallace Souza Silva on 31/07/18.
//  Copyright © 2018 WallaCorp. All rights reserved.
//

import Foundation
import UIKit

protocol TopGamesRouterInterface {
    func showDetails(ofGame game: GameModel)
}

class TopGamesRouter: TopGamesRouterInterface {
    
    let view: UIViewController
    
    init(view: UIViewController) {
        self.view = view
    }
    
    class func createModule() -> UIViewController {
        // Generating module components
        var view: TopGamesViewInterface = TopGamesViewController()
        var presenter: TopGamesPresenterInterface & TopGamesInteractorOutput = TopGamesPresenter()
        var interactor: TopGamesInteractorInput = TopGamesInteractor()
        let router: TopGamesRouterInterface = TopGamesRouter(view: view as! UIViewController)
        
        // Connecting
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view as! UIViewController
    }
    
    func showDetails(ofGame game: GameModel) {
        let detailsViewController = GameDetailsRouter.createModule(withGame: game)
        detailsViewController.hidesBottomBarWhenPushed = true
        view.navigationController?.show(detailsViewController, sender: self)
    }
}
