//
//  FavoriteGamesViewController.swift
//  Farfetch Challenge
//
//  Created by Wallace Souza Silva on 24/07/18.
//  Copyright © 2018 WallaCorp. All rights reserved.
//

import Foundation
import UIKit
import Cartography

class FavoriteGamesViewController: UIViewController {
    
    var presenter: FavoriteGamesPresenterInterface?
    
    let collectionView: UICollectionView = {
        let collectionViewLayout = ColumnsFlowLayout(numberOfColumns: 2)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.backgroundColor = UIColor.clear
        collectionView.register(GameCollectionViewCell.self)
        return collectionView
    }()
    
    let emptyStateView = EmptyStateView(title: "You don't have\nFavorite Games")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Favorites"
        setupViews()
        presenter?.viewDidLoad()
    }
    
    private func setupViews() {
        view.backgroundColor = UIColor.white
        view.addSubview(collectionView)
        view.addSubview(emptyStateView)
        constrainSubviews()
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    private func constrainSubviews() {
        constrain(collectionView, emptyStateView, view) { list, emptyState, container in
            list.edges == container.edges
            emptyState.edges == container.edges
        }
    }
}

extension FavoriteGamesViewController: FavoriteGamesViewInterface {
    
    func showEmptyState() {
        emptyStateView.isHidden = false
    }
    
    func hideEmptyState() {
        emptyStateView.isHidden = true
    }
    
    func reloadGames() {
        collectionView.reloadData()
    }
    
    func updateIndices(toInsertIndexes: [Int], toDeleteIndexes: [Int]) {
        collectionView.performBatchUpdates({
            collectionView.deleteItems(at: toDeleteIndexes.map{ return IndexPath(row: $0, section: 0)})
            collectionView.insertItems(at: toInsertIndexes.map{ return IndexPath(row: $0, section: 0)})
        }, completion: nil)
    }
}

extension FavoriteGamesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.numberOfGames ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.deque(GameCollectionViewCell.self, forIndexPath: indexPath)
        presenter?.configure(view: cell, at: indexPath.row)
        cell.callback = {
            self.presenter?.favoriteButtonTapped(at: indexPath.row)
        }
        cell.backgroundColor = UIColor(red: CGFloat(arc4random_uniform(255))/255.0,
                                       green: CGFloat(arc4random_uniform(255))/255.0,
                                       blue: CGFloat(arc4random_uniform(255))/255.0,
                                       alpha: 1.0)
        
        return cell
    }
}

extension FavoriteGamesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.didSelectGame(at: indexPath.row)
    }    
}


