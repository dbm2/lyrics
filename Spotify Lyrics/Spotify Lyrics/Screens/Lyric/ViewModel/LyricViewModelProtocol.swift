//
//  LyricViewModelProtocol.swift
//  Spotify Lyrics
//
//  Created by Daniel Maranhão on 10/10/19.
//  Copyright © 2019 Daniel Maranhão. All rights reserved.
//

import Foundation

protocol LyricViewModelProtocol {
    
    var delegate: LyricViewModelDelegate? { get set }
    
    var userName: String { get }
    var userProfilePictureURL: URL? { get }
    
    var isPlaying: Bool { get }
    var trackName: String? { get }
    var trackAlbumName: String? { get }
    var trackArtistName: String? { get }
    var trackAlbumPictureURL: URL? { get }
    
    var lyric: String { get }
    
    func prepareContent()
    func logout()
}
