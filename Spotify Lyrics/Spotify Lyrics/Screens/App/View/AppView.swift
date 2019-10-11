//
//  AppView.swift
//  Spotify Lyrics
//
//  Created by Daniel Maranhão on 10/10/19.
//  Copyright © 2019 Daniel Maranhão. All rights reserved.
//

import UIKit

final class AppView: UIViewController {
 
    private var viewModel: AppViewModelProtocol!
    
    convenience init(with viewModel: AppViewModelProtocol) {
        self.init()
        self.viewModel = viewModel
        self.viewModel.delegate = self
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.prepareApplication()
    }
    
    @objc private func didLoginWithSuccess() {
        viewModel.prepareApplication()
    }
}

extension AppView: AppViewModelDelegate {
    func presentLogin() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(didLoginWithSuccess),
                                               name: Spotify.loginNotification,
                                               object: nil)
        Spotify.login(from: self)
    }
    
    func presentLyric(with viewModel: LyricViewModelProtocol) {
        LyricView.present(in: self, with: viewModel)
    }
}
