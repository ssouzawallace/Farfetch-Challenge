//
//  GameCollectionViewCell.swift
//  Farfetch Challenge
//
//  Created by Wallace Souza Silva on 24/07/18.
//  Copyright © 2018 WallaCorp. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage
import Cartography

typealias FavoriteButtonTappedCallback = () -> Void

class GameCollectionViewCell: UICollectionViewCell {
    let coverImageView: UIImageView = {
        return UIImageView(frame: .zero)
    }()
    let favoriteButton: UIButton = {
        return UIButton(type: .custom)
    }()
    let titleLabel: UILabel = {
        let titleLabel = UILabel(frame: .zero)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        titleLabel.baselineAdjustment = .alignCenters
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.textColor = UIColor.white
        titleLabel.backgroundColor = UIColor.black
        return titleLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    private func setup() {
        contentView.addSubview(coverImageView)
        contentView.addSubview(favoriteButton)
        contentView.addSubview(titleLabel)
        constrainSubviews()
        favoriteButton.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
    }
    
    private func constrainSubviews() {
        constrain(titleLabel, favoriteButton, coverImageView, contentView) { title, favorite, image, container in
            title.height == 40
            title.bottom == container.bottom
            title.leading == container.leading
            title.trailing == container.trailing
            
            image.top == container.top
            image.leading == container.leading
            image.trailing == container.trailing
            image.bottom == title.top
            
            favorite.trailing == container.trailing - 8
            favorite.top == container.top + 8
        }
    }
    
    var callback: FavoriteButtonTappedCallback? = nil
    
    func setup(coverImageUrl: String, title: String, isFavorite: Bool, callback: FavoriteButtonTappedCallback? = nil) {
        titleLabel.text = title
        favoriteButton.setTitle(isFavorite ? "★": "☆", for: .normal)
        coverImageView.sd_setImage(with: URL(string: coverImageUrl), placeholderImage: nil)
        self.callback = callback
    }
    
    @objc func favoriteButtonTapped(_ button: UIButton) {
        callback?()
    }
}

extension GameCollectionViewCell: GameDisplayableView {
    func configureWith(game: GameViewModel) {
        titleLabel.text = game.name
        favoriteButton.setTitle(game.isFavorite ? "★": "☆", for: .normal)
        coverImageView.sd_setImage(with: URL(string: game.boxArtUrl(forImageType: .thumbnail)), placeholderImage: nil)
    }
}
