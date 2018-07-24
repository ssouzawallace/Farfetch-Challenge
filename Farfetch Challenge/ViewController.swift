//
//  ViewController.swift
//  Farfetch Challenge
//
//  Created by Wallace Souza Silva on 24/07/18.
//  Copyright © 2018 WallaCorp. All rights reserved.
//

import UIKit

class FlowLayout: UICollectionViewFlowLayout {
    override init() {
        super.init()
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLayout()
    }
    
    func setupLayout() {
        minimumInteritemSpacing = 5
        minimumLineSpacing = 5
        scrollDirection = .vertical
    }
    
    override var itemSize: CGSize {
        set {
            
        }
        get {
            let numberOfColumns: CGFloat = 2
            let itemWidth = (self.collectionView!.frame.width - (numberOfColumns - 1)) / numberOfColumns - minimumLineSpacing/2
            return CGSize(width: itemWidth, height: itemWidth)
        }
    }
}

class ViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView?
    
    let games:[GameModel] = [GameModel(id: "123", name: "nome1", box_art_url: "alkdsj"),
                             GameModel(id: "123", name: "nome2", box_art_url: "alkdsj"),
                             GameModel(id: "123", name: "nome3", box_art_url: "alkdsj"),
                             GameModel(id: "123", name: "nome4", box_art_url: "alkdsj"),
                             GameModel(id: "123", name: "nome5", box_art_url: "alkdsj")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.dataSource = self
        collectionView?.delegate = self
        collectionView?.collectionViewLayout = FlowLayout()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return games.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "gameCell", for: indexPath)
        
        cell.backgroundColor = UIColor(red: CGFloat(arc4random_uniform(255))/255.0,
                                       green: CGFloat(arc4random_uniform(255))/255.0,
                                       blue: CGFloat(arc4random_uniform(255))/255.0,
                                       alpha: 1.0)
        
        return cell
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetails", sender: nil)
    }
}

