//
//  GameListViewController.swift
//  Farfetch Challenge
//
//  Created by Wallace Souza Silva on 24/07/18.
//  Copyright © 2018 WallaCorp. All rights reserved.
//

import Foundation
import UIKit

protocol GameListRenderer {
    func render(games: [GameModel])
    var delegate: GameListDelegate? { get set }
}

protocol GameListDelegate {
//    func didSelectGameAt(index: Int)
//    func favoriteButtonTappedAt(index: Int)
    func listIsReachingEnd()
}

class GameListViewController: UIViewController, GameListRenderer {

    @IBOutlet weak var collectionView: UICollectionView?
    
    var delegate: GameListDelegate? = nil
    
    var games: [GameModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.dataSource = self
        collectionView?.delegate = self
        collectionView?.collectionViewLayout = ColumnsFlowLayout(numberOfColumns: 2)
    }
    
    func render(games: [GameModel]) {
        self.games = games
        collectionView?.reloadData()
    }
}

extension GameListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return games.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "gameCell", for: indexPath)
        if let cell = cell as? GameCollectionViewCell {
            let game = games[indexPath.row]
            let gameViewModel = GameViewModel(game: game)
            let boxArtUrl = gameViewModel.boxArtUrl(forHeight: Int(collectionView.collectionViewLayout.layoutAttributesForItem(at: indexPath)?.size.height ?? 0))
            
            cell.setup(coverImageUrl: boxArtUrl, title: game.name, isFavorite: false)
        }
        cell.backgroundColor = UIColor(red: CGFloat(arc4random_uniform(255))/255.0,
                                       green: CGFloat(arc4random_uniform(255))/255.0,
                                       blue: CGFloat(arc4random_uniform(255))/255.0,
                                       alpha: 1.0)
        
        return cell
    }
}

extension GameListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetails", sender: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row > games.count - 5 {
            delegate?.listIsReachingEnd()
        }
    }
}

