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
    var trackName: String? {
        return track?.name
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
    
    var hasLyric: Bool {
        return lyricMusic?.text != nil
    }
    
    var lyric: String? {
        return lyricMusic?.text
    }
    
    private var user: User?
    private var track: Track?
    private var lyricMusic: LyricMusic?
    
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
    
    func logout() {
        syncer?.stop()
        Spotify.logout()
        delegate?.presentApp()
    }
    
    private func syncPlayer() {
        guard let token = Spotify.currentToken else { return }
        syncer = Syncer<Player>(with: Constants.Syncer.updateTimeout,
                                and: Request.getCurrentlyPlaying(with: token))
        syncer?.updateHandler = didReceivePlayer
        syncer?.listen()
    }
    
    private func fetchLyric() {
        guard let track = track else { return }
        _ = Request.searchLyric(forTrack: track.name, andArtist: track.artists.first?.name ?? "")
            .replaceError(with: LyricSearch(mus: []))
            .sink(receiveValue: { [weak self] (search) in
                self?.lyricMusic = search.mus?.first
                self?.delegate?.didUpdateLyricInformations()
            })
    }
    
    private lazy var didReceivePlayer: (Player?) -> Void = { [weak self] player in
        guard self?.track?.id != player?.item?.id else { return }
        let changedAlbum = self?.track?.album.id != player?.item?.album.id
        self?.track = player?.item
        self?.delegate?.didUpdateTrackInformations(changedAlbum: changedAlbum)
        self?.fetchLyric()
    }
}
