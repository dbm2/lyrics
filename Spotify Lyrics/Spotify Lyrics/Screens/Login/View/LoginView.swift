//
//  LoginView.swift
//  Spotify Lyrics
//
//  Created by Daniel Maranhão on 11/10/19.
//  Copyright © 2019 Daniel Maranhão. All rights reserved.
//

import UIKit

final class LoginView: UIViewController {
    
    @IBOutlet private weak var btnLogin: UIButton!
    
    static func present(in view: UIViewController) {
        let loginView = LoginView()
        loginView.modalPresentationStyle = .fullScreen
        view.present(loginView, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnLogin.layer.cornerRadius = 10.0
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(didLoginWithSuccess),
                                               name: Spotify.loginNotification,
                                               object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    @IBAction func login(_ sender: UIButton) {
        Spotify.login(from: self)
    }
    
    @objc private func didLoginWithSuccess() {
        LyricView.present(in: self)
    }
}
