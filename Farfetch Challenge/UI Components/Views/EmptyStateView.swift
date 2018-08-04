//
//  EmptyStateView.swift
//  Farfetch Challenge
//
//  Created by Wallace Souza Silva on 04/08/18.
//  Copyright © 2018 WallaCorp. All rights reserved.
//

import Foundation
import UIKit
import Cartography

class EmptyStateView: UIView {
    
    let titleLabel: UILabel = {
        let titleLabel = UILabel(frame: .zero)
        titleLabel.numberOfLines = 0
        return titleLabel
    }()
    
    init(title: String) {
        super.init(frame: .zero)
        setupSubviews()
        titleLabel.text = title
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        addSubview(titleLabel)
        constrain(titleLabel, self) { title, container in
            title.center == container.center
        }
    }
}
