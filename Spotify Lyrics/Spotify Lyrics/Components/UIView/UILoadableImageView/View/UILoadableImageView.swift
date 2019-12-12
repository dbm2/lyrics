//
//  UILoadableImageView.swift
//  Spotify Lyrics
//
//  Created by Daniel Maranhão on 10/10/19.
//  Copyright © 2019 Daniel Maranhão. All rights reserved.
//

import UIKit

final class UILoadableImageView: UIImageView {
    
    private var viewModel: UILoadableImageViewModelProtocol = UILoadableImageViewModel()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
       let activityIndicator = UIActivityIndicatorView()
        activityIndicator.frame = bounds
        activityIndicator.color = .white
        activityIndicator.startAnimating()
        return activityIndicator
    }()

    func load(from url: URL?, placeholder: UIImage? = nil, with completion: (() -> Void)? = nil) {
        image = nil
        
        if activityIndicator.superview == nil {
            addSubview(activityIndicator)
        }
        activityIndicator.isHidden = false
    
        self.viewModel.load(from: url) { [weak self] data in
            self?.activityIndicator.isHidden = true
            self?.image = UIImage(data: data) ?? placeholder
            completion?()
        }
    }
}

