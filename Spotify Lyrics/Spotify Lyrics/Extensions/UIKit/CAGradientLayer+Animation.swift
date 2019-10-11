//
//  CAGradientLayer+Animation.swift
//  Spotify Lyrics
//
//  Created by Daniel Maranhão on 10/10/19.
//  Copyright © 2019 Daniel Maranhão. All rights reserved.
//

import UIKit

extension CAGradientLayer {
    
    func animate(to colors: [CGColor], with duration: TimeInterval) {
        let gradientChangeColor = CABasicAnimation(keyPath: "colors")
        gradientChangeColor.duration = duration
        gradientChangeColor.fromValue = self.colors
        gradientChangeColor.toValue = colors
        gradientChangeColor.fillMode = CAMediaTimingFillMode.forwards
        gradientChangeColor.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        gradientChangeColor.isRemovedOnCompletion = false
        add(gradientChangeColor, forKey: "colorChange")
        self.colors = colors
    }
}
