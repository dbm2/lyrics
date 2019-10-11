//
//  Spotify.swift
//  Spotify Lyrics
//
//  Created by Daniel Maranhão on 10/10/19.
//  Copyright © 2019 Daniel Maranhão. All rights reserved.
//

import Foundation
import SpotifyLogin

final class Spotify {
    
    static var currentToken: String?
    
    static let loginNotification: NSNotification.Name = .SpotifyLoginSuccessful
    
    static func configure(with clientID: String, clientSecrect: String, redirectURL: URL) {
        SpotifyLogin.shared.configure(clientID: clientID,
                                      clientSecret: clientSecrect,
                                      redirectURL: redirectURL)
    }
    
    @discardableResult
    static func handle(_ url: URL) -> Bool {
        return SpotifyLogin.shared.applicationOpenURL(url) { _ in }
    }
 
    static func getCurrentToken(with completion: @escaping (String?) -> Void) {
        SpotifyLogin.shared.getAccessToken { (token, _) in
            completion(token)
        }
    }
    
    static func login(from view: UIViewController) {
        SpotifyLoginPresenter.login(from: view, scopes: [.userReadPrivate,
                                                         .userReadCurrentlyPlaying])
    }
}
