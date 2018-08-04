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

protocol EmptyStateViewDelegate: class {
    func emptyStateActionRequested()
}

class EmptyStateView: UIView {
    
    private let titleLabel: UILabel = {
        let titleLabel = UILabel(frame: .zero)
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        titleLabel.textColor = UIColor.white
        return titleLabel
    }()
    
    private let actionButton: UIButton = {
        let actionButton = UIButton(type: .custom)
        actionButton.setTitleColor(UIColor.twitchPurple, for: .normal)
        return actionButton
    }()
    
    weak var delegate: EmptyStateViewDelegate?
    
    init(title: String, actionTitle: String? = nil) {
        super.init(frame: .zero)
        titleLabel.text = title        
        actionButton.setTitle(actionTitle, for: .normal)
        actionButton.addTarget(self, action: #selector(actionButtonTapped(_:)), for: .touchUpInside)
        
        setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        addSubview(titleLabel)
        addSubview(actionButton)
        constrain(titleLabel, actionButton, self) { title, action, container in
            title.center == container.center
            action.centerX == container.centerX
            action.top == title.bottom + 20
        }
    }
    
    @objc func actionButtonTapped(_ button: UIButton) {
        delegate?.emptyStateActionRequested()
    }
}
