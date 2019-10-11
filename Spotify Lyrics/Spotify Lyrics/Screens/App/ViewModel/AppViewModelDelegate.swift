//
//  AppViewModelDelegate.swift
//  Spotify Lyrics
//
//  Created by Daniel Maranhão on 10/10/19.
//  Copyright © 2019 Daniel Maranhão. All rights reserved.
//

import Foundation

protocol AppViewModelDelegate: class {
    
    func presentLogin()
    func presentLyric(with viewModel: LyricViewModelProtocol)
}
