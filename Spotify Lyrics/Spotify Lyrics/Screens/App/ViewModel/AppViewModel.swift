//
//  AppViewModel.swift
//  Spotify Lyrics
//
//  Created by Daniel Maranhão on 10/10/19.
//  Copyright © 2019 Daniel Maranhão. All rights reserved.
//

import Foundation

final class AppViewModel: AppViewModelProtocol {
    
    weak var delegate: AppViewModelDelegate?
    
    func prepareApplication() {
        Spotify.getCurrentToken { [unowned self] (token) in
            guard let token = token else {
                self.delegate?.presentLogin()
                return
            }
            
            Spotify.currentToken = token
            self.delegate?.presentLyric(with: LyricViewModel())
        }
    }
}
