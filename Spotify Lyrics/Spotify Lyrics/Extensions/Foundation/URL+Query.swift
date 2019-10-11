//
//  URL+Query.swift
//  Spotify Lyrics
//
//  Created by Daniel Maranhão on 11/10/19.
//  Copyright © 2019 Daniel Maranhão. All rights reserved.
//

import Foundation

extension URL {
    func queried(by queries: [String: String]) -> URL {
        guard queries.count > 0 else {
            return self
        }
        
        var queriedURL = URLComponents(url: self, resolvingAgainstBaseURL: false)
        
        queriedURL?.queryItems = queries.map({ URLQueryItem(name: $0.key, value: $0.value) })
        
        return queriedURL?.url ?? self
    }
}
