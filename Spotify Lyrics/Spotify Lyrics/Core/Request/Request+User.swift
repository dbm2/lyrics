//
//  Request+Profile.swift
//  Spotify Lyrics
//
//  Created by Daniel Maranhão on 10/10/19.
//  Copyright © 2019 Daniel Maranhão. All rights reserved.
//

import Foundation
import Combine

extension Request {
    
    static func getCurrentUser(with token: String) -> AnyPublisher<User, Error> {
        let request = Constants.Spotify.Request.self
        let url = request.hostname.appendingPathComponent(request.Endpoint.profile)
        
        return HTTP.request(for: url,
                            using: .GET,
                            content: .json,
                            authorization: .bearer(auth: token))
    }
}
