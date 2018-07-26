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

class GameCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var coverImageView: UIImageView?
    @IBOutlet weak var favoriteButton: UIButton?
    @IBOutlet weak var titleLabel: UILabel?
    
    func setup(coverImageUrl: String, title: String, isFavorite: Bool) {
        titleLabel?.text = title
        favoriteButton?.setTitle(isFavorite ? "★": "☆", for: .normal)
        coverImageView?.sd_setImage(with: URL(string: coverImageUrl), placeholderImage: nil)
    }
}
