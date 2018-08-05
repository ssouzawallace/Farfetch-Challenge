//
//  UIView+Animations.swift
//  Farfetch Challenge
//
//  Created by Wallace Souza Silva on 04/08/18.
//  Copyright © 2018 WallaCorp. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    enum Animation: String {
        case pump
    }
    
    func applyAnimation(_ animation: Animation) {
        layer.add(keyframeAnimationForAnimation(animation), forKey: animation.rawValue)
    }
    
    private func keyframeAnimationForAnimation(_ animation: Animation) -> CAKeyframeAnimation {
        switch animation {
        case .pump:
            return pumpKeyframeAnimation()
        }
    }
    
    private func pumpKeyframeAnimation() -> CAKeyframeAnimation {
        let pumpKeyframeAnimation = CAKeyframeAnimation()
        
        pumpKeyframeAnimation.keyPath = "transform.scale"
        pumpKeyframeAnimation.values = [0.95, 0.90, 0.85, 1.0, 1.2, 1.0]
        pumpKeyframeAnimation.duration = 0.5
        pumpKeyframeAnimation.calculationMode = kCAAnimationCubic
        
        return pumpKeyframeAnimation
    }
}
