//
//  UIColor+GradientScale.swift
//  Spotify Lyrics
//
//  Created by Daniel Maranhão on 10/10/19.
//  Copyright © 2019 Daniel Maranhão. All rights reserved.
//

import UIKit

extension UIColor {
    
    func gradientScale() -> [UIColor] {
        
        var clearColor = self
        while clearColor.getLuminance() < 50.0 {
            clearColor = clearColor.adjust(0.01)
        }
        while clearColor.getLuminance() > 50.0 {
            clearColor = clearColor.adjust(-0.01)
        }
        
        var darkerColor = self
        while darkerColor.getLuminance() < 30.0 {
            darkerColor = darkerColor.adjust(0.01)
        }
        while darkerColor.getLuminance() > 30.0 {
            darkerColor = darkerColor.adjust(-0.01)
        }
        
        return [clearColor, darkerColor]
    }
    
    private func getLuminance() -> CGFloat {
        var r: CGFloat = 0.0
        var g: CGFloat = 0.0
        var b: CGFloat = 0.0
        var a: CGFloat = 0.0
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        
        return ((0.2126*r) + (0.7152*g) + (0.0722*b))*100
    }
    
    private func adjust(_ ammount: CGFloat) -> UIColor {
        var h: CGFloat = 0
        var s: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        
        if self.getHue(&h, saturation: &s, brightness: &b, alpha: &a) {
            return UIColor(hue: h, saturation: s, brightness: b * (1 + ammount), alpha: a)
        }
        
        return self
    }
}

