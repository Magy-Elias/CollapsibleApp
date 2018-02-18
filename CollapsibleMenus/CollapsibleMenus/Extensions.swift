//
//  Extensions.swift
//  CollapsibleMenus
//
//  Created by Mickey Goga on 2/18/18.
//  Copyright © 2018 Magy Elias. All rights reserved.
//

import UIKit

extension UIView {
    func rotate(_ toValue: CGFloat, duration: CFTimeInterval = 0.2) {
        let animation = CABasicAnimation(keyPath: "transform.rotation")
//
        animation.toValue = toValue     //Defines the value the receiver uses to end interpolation.
        animation.duration = duration   //Defines the time of animation
        animation.isRemovedOnCompletion = false
        animation.fillMode = kCAFillModeForwards    //the receiver remains visible in its final state when the animation is completed
        
        self.layer.add(animation, forKey: nil)
    }
}
