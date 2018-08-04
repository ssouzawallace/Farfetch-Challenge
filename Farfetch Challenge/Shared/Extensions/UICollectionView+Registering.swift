//
//  UICollectionView+Registering.swift
//  Farfetch Challenge
//
//  Created by Wallace Souza Silva on 01/08/18.
//  Copyright © 2018 WallaCorp. All rights reserved.
//

import Foundation
import UIKit

extension UICollectionView {
    
    private func reuseIdentifierFor(_ cellClass: AnyClass) -> String {
        return cellClass.description()
    }
    
    func register(_ cellClass: AnyClass) {
        register(cellClass, forCellWithReuseIdentifier: reuseIdentifierFor(cellClass))
    }
    func deque<CellType: UICollectionViewCell>(_ cellClass: CellType.Type, forIndexPath indexPath: IndexPath) -> CellType {
        return dequeueReusableCell(withReuseIdentifier: reuseIdentifierFor(cellClass), for: indexPath) as! CellType
    }
}
