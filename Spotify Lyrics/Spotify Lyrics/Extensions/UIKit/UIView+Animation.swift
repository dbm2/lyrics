//
//  UIView+Animation.swift
//  Spotify Lyrics
//
//  Created by Daniel Maranhão on 11/10/19.
//  Copyright © 2019 Daniel Maranhão. All rights reserved.
//

import UIKit

extension UIView {
    
    func animate(to alpha: CGFloat, with duration: TimeInterval) {
        guard self.alpha != alpha else { return }
        UIView.animate(withDuration: duration) { [unowned self] in
            self.alpha = alpha
        }
    }
    
    static func animate(with duration: TimeInterval, to alpha: CGFloat, views: UIView...) {
        views.forEach { $0.animate(to: alpha, with: duration) }
    }
}
