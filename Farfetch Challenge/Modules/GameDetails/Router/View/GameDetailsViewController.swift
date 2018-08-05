//
//  GameDetailsViewController.swift
//  Farfetch Challenge
//
//  Created by Wallace Souza Silva on 24/07/18.
//  Copyright © 2018 WallaCorp. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage
import Cartography

class GameDetailsViewController: UIViewController {
    
    var presenter: GameDetailsPresenterInterface?
    
    let coverImageView: UIImageView = {
        return UIImageView(frame: .zero)
    }()
    let nameLabel: UILabel = {
        let nameLabel = UILabel(frame: .zero)
        nameLabel.textAlignment = .center
        nameLabel.textColor = UIColor.white
        nameLabel.numberOfLines = 0
        nameLabel.font = UIFont.systemFont(ofSize: 30)
        return nameLabel
    }()
    let favoriteBarButtonItem: UIBarButtonItem = {
        let favoriteBarButtonItem = UIBarButtonItem()
        return favoriteBarButtonItem
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSubviews()
        
        presenter?.viewDidLoad()
    }
    
    private func setupSubviews() {
        view.backgroundColor = UIColor.backgroundColor
        favoriteBarButtonItem.target = self
        favoriteBarButtonItem.action = #selector(favoriteBarButtonTapped(_:))
        navigationItem.rightBarButtonItem = favoriteBarButtonItem
        view.addSubview(coverImageView)
        view.addSubview(nameLabel)
        constrainSubviews()
    }
    
    private func constrainSubviews() {
        constrain(coverImageView, nameLabel, view) { image, label, container in
            image.top == container.safeAreaLayoutGuide.topMargin + 40
            image.leading == container.leading + 40
            image.trailing == container.trailing - 40
            
            label.centerX == container.centerX
            label.top == image.bottom + 8
            label.leading == container.leading + 20
            label.trailing == container.trailing - 20
            
        }
        coverImageView.addConstraint(NSLayoutConstraint(item: coverImageView,
                                                        attribute: .height,
                                                        relatedBy: .equal,
                                                        toItem: coverImageView,
                                                        attribute: .width,
                                                        multiplier: 4.0 / 3.0,
                                                        constant: 0))
    }
    
    @objc func favoriteBarButtonTapped(_ sender: UIBarButtonItem) {
        presenter?.favoriteButtonTapped()
    }
}

extension GameDetailsViewController: GameDetailsViewInterface {
    func configureWith(game: GameViewModel) {
        nameLabel.text = game.name
        
        let boxArtUrl = game.boxArtUrl(forImageType: .fullImage)
        coverImageView.sd_setImage(with: URL(string: boxArtUrl), placeholderImage: nil)
     
        
        let favoriteIconImage = game.isFavorite ? UIImage(named: "heart_barIcon_filled") : UIImage(named: "heart_barIcon_outline")
        if game.isFavorite {
            (favoriteBarButtonItem.value(forKey: "view") as? UIView)?.applyAnimation(.pump)
        }
        self.favoriteBarButtonItem.image = favoriteIconImage
        
    }
}
