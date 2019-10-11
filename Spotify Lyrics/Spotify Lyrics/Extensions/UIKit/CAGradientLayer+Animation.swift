//
//  CAGradientLayer+Animation.swift
//  Spotify Lyrics
//
//  Created by Daniel Maranhão on 10/10/19.
//  Copyright © 2019 Daniel Maranhão. All rights reserved.
//

import UIKit

extension CAGradientLayer {
    
    @discardableResult
    func animate(toColors colors: [CGColor],
                 withDuration duration: TimeInterval,
                 withDelegate delegate: CAAnimationDelegate? = nil) -> (CABasicAnimation, String)  {
        
        let gradientChangeColor = CABasicAnimation(keyPath: "colors")
        gradientChangeColor.duration = duration
        gradientChangeColor.fromValue = self.colors
        gradientChangeColor.toValue = colors
        gradientChangeColor.fillMode = CAMediaTimingFillMode.forwards
        gradientChangeColor.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        gradientChangeColor.isRemovedOnCompletion = false
        gradientChangeColor.delegate = delegate
        
        self.add(gradientChangeColor, forKey: "colorChange")
        
        return (gradientChangeColor, "colorChange")
    }
}
