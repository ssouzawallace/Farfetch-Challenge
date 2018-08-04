//
//  ColumnsFlowLayout.swift
//  Farfetch Challenge
//
//  Created by Wallace Souza Silva on 24/07/18.
//  Copyright © 2018 WallaCorp. All rights reserved.
//

import Foundation
import UIKit

class ColumnsFlowLayout: UICollectionViewFlowLayout {
    let numberOfColumns: Int
    
    init(numberOfColumns: Int) {
        self.numberOfColumns = numberOfColumns
        super.init()
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
            let numberOfColumns = CGFloat(self.numberOfColumns)
            let itemWidth = (self.collectionView!.frame.width - (numberOfColumns - 1)) / numberOfColumns - minimumLineSpacing/2
            let itemHeight = itemWidth*4/3 + 40
            return CGSize(width: itemWidth, height: itemHeight)
        }
    }
}
