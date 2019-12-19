//
//  LyricViewModelDelegate.swift
//  Spotify Lyrics
//
//  Created by Daniel Maranhão on 10/10/19.
//  Copyright © 2019 Daniel Maranhão. All rights reserved.
//

import Foundation

protocol LyricViewModelDelegate: class {
    
    func didUpdateUserInformations()
    
    func didEndRefreshing()
    
    func didUpdateTrackInformations(changedAlbum: Bool)
    func didUpdateLyricInformations()

    func presentApp()
}
