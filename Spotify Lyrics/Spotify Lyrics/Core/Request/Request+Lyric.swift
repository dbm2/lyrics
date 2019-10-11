//
//  Request+Lyric.swift
//  Spotify Lyrics
//
//  Created by Daniel Maranhão on 11/10/19.
//  Copyright © 2019 Daniel Maranhão. All rights reserved.
//

import Foundation
import Combine

extension Request {
    
    static func searchLyric(forTrack trackName: String, andArtist artistName: String) -> AnyPublisher<LyricSearch, Error> {
        let request = Constants.Vagamule.Request.self
        let url = request.hostname.appendingPathComponent(request.Endpoint.search)
        
        let parameters: [String: String] = [
            "art": artistName,
            "mus": trackName,
            "apikey": Constants.Vagamule.Authorization.ApiKey
        ]
        
        return HTTP.request(for: url.queried(by: parameters),
                            using: .GET,
                            content: .json)
    }
}
