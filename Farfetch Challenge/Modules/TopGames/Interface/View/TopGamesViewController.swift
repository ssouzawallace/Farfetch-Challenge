//
//  TopGamesViewController.swift
//  Farfetch Challenge
//
//  Created by Wallace Souza Silva on 24/07/18.
//  Copyright © 2018 WallaCorp. All rights reserved.
//

import Foundation
import UIKit
import Cartography

class TopGamesViewController: UIViewController {
    
    override var title: String? {
        get {
            return "Top Games"
        }
        set { /* do nothing */ }
    }
    
    var presenter: TopGamesPresenterInterface?
    
    let collectionView: UICollectionView = {
        let collectionViewLayout = ColumnsFlowLayout(numberOfColumns: 2)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.backgroundColor = UIColor.clear
        collectionView.register(GameCollectionViewCell.self)
        return collectionView
    }()
    
    let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .white)
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    
    let noInternetEmptyStateView = EmptyStateView(title: "Request failed\nVerify you internet connection", actionTitle: "Try again")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    
        presenter?.start()
    }
    
    private func setupViews() {
        view.backgroundColor = UIColor.backgroundColor
        view.addSubview(collectionView)
        view.addSubview(activityIndicator)
        view.addSubview(noInternetEmptyStateView)
        constrainSubviews()
        collectionView.delegate = self
        collectionView.dataSource = self
        noInternetEmptyStateView.delegate = self
    }
    
    private func constrainSubviews() {
        constrain(collectionView, activityIndicator, noInternetEmptyStateView, view) { list, loader, emptyState, container in
            list.edges == container.edges
            emptyState.edges == container.edges
            loader.center == container.center
        }
    }
}

extension TopGamesViewController: EmptyStateViewDelegate {
    func emptyStateActionRequested() {
        presenter?.start()
    }
}

extension TopGamesViewController: TopGamesViewInterface {
    
    func showNoInternetMessage() {
        noInternetEmptyStateView.isHidden = false
    }
    
    func hideNoInternetMessage() {
        noInternetEmptyStateView.isHidden = true
    }
    
    func showLoader() {
        activityIndicator.startAnimating()
    }
    
    func hideLoader() {
        activityIndicator.stopAnimating()
    }
    
    func reloadGames() {
        collectionView.reloadData()
    }
}

extension TopGamesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.numberOfGames ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.deque(GameCollectionViewCell.self, forIndexPath: indexPath)
        presenter?.configure(view: cell, at: indexPath.row)
        cell.callback = {
            guard let indexOfCell = collectionView.indexPath(for: cell) else { return }
            self.presenter?.favoriteButtonTapped(at: indexOfCell.row)
        }
        cell.backgroundColor = UIColor(red: CGFloat(arc4random_uniform(255))/255.0,
                                       green: CGFloat(arc4random_uniform(255))/255.0,
                                       blue: CGFloat(arc4random_uniform(255))/255.0,
                                       alpha: 1.0)
        
        return cell
    }
}

extension TopGamesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.didSelectGame(at: indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let numberOfGames = presenter?.numberOfGames else {
            return
        }
        if indexPath.row > numberOfGames - 5 {
            presenter?.listIsReachingEnd()
        }
    }
}

