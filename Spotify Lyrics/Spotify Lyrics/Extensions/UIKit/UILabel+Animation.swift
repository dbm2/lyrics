//
//  UILabel+Animation.swift
//  Spotify Lyrics
//
//  Created by Daniel Maranhão on 11/10/19.
//  Copyright © 2019 Daniel Maranhão. All rights reserved.
//

import UIKit

extension UILabel {
    
    func animate(to text: String?, with duration: TimeInterval) {
        UIView.transition(with: self, duration: duration, options: .transitionCrossDissolve, animations: { [unowned self] in
            self.text = text
        }, completion: .none)
    }
    
    static func animate(with duration: TimeInterval, viewsTexts: (UILabel, String?)...) {
        viewsTexts.forEach { $0.0.animate(to: $0.1, with: duration) }
    }
}

