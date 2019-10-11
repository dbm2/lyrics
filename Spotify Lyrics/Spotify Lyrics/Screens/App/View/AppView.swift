//
//  AppView.swift
//  Spotify Lyrics
//
//  Created by Daniel Maranhão on 10/10/19.
//  Copyright © 2019 Daniel Maranhão. All rights reserved.
//

import UIKit

final class AppView: UIViewController {
    
    private var viewModel: AppViewModelProtocol = AppViewModel()
    
    static func present(in view: UIViewController) {
        let appView = AppView()
        appView.modalPresentationStyle = .fullScreen
        view.present(appView, animated: false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.delegate = self
        viewModel.prepareApplication()
    }
}

extension AppView: AppViewModelDelegate {
    func presentLogin() {
        LoginView.present(in: self)
    }
    
    func presentLyric() {
        LyricView.present(in: self)
    }
}
