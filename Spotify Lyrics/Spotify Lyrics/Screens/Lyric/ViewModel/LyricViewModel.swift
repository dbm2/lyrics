//
//  LyricViewModel.swift
//  Spotify Lyrics
//
//  Created by Daniel Maranhão on 10/10/19.
//  Copyright © 2019 Daniel Maranhão. All rights reserved.
//

import Foundation

final class LyricViewModel: LyricViewModelProtocol {
    
    weak var delegate: LyricViewModelDelegate?
    
    var userName: String {
        return user?.name ?? "User"
    }
    
    var userProfilePictureURL: URL? {
        guard let stringURL = user?.images?.first?.url else { return nil }
        return URL(string: stringURL)
    }
    
    var isPlaying: Bool {
        return track != nil
    }
    var trackName: String {
        return track?.name ?? "Currently playing"
    }
    
    var trackAlbumName: String? {
        return track?.album.name
    }
    
    var trackArtistName: String? {
        return track?.artists.first?.name
    }
    
    var trackAlbumPictureURL: URL? {
        guard let stringURL = track?.album.images?.first?.url else { return nil }
        return URL(string: stringURL)
    }
    
    private var user: User?
    private var track: Track?
    
    private var syncer: Syncer<Player>?
    
    func prepareContent() {
        guard let token = Spotify.currentToken else { return }
        _ = Request.getCurrentUser(with: token)
            .sink(receiveCompletion: { _ in }, receiveValue: { [weak self] (user) in
                self?.user = user
                self?.delegate?.didUpdateUserInformations()
                self?.syncPlayer()
            })
    }
    
    private func syncPlayer() {
        guard let token = Spotify.currentToken else { return }
        syncer = Syncer<Player>(with: Constants.Syncer.updateTimeout,
                                and: Request.getCurrentlyPlaying(with: token))
        syncer?.updateHandler = didReceivePlayer
        syncer?.listen()
    }
    
    private lazy var didReceivePlayer: (Player?) -> Void = { [weak self] player in
        guard self?.track?.id != player?.item?.id else { return }
        let changedAlbum = self?.track?.album.id != player?.item?.album.id
        self?.track = player?.item
        self?.delegate?.didUpdateTrackInformations(changedAlbum: changedAlbum)
    }
}
