//
//  Constants.swift
//  Spotify Lyrics
//
//  Created by Daniel Maranhão on 10/10/19.
//  Copyright © 2019 Daniel Maranhão. All rights reserved.
//

import Foundation

struct Constants {
    
    struct Spotify {
        
        struct Authorization {
            static let ClientID: String = "48e97313046041a18aa518d6fac1ec2b"
            static let ClientSecret: String = "e3fbe1511cec440993d3eaa11f6b0705"
            static let RedirectURL: URL = URL(string: "lyrics://")!
        }
        
        struct Request {
            static let hostname: URL = URL(string: "https://api.spotify.com/v1")!
            
            struct Endpoint {
                static let profile: String = "me"
                static let currentlyPlaying: String = "me/player/currently-playing"
            }
        }
    }
    
    struct Vagamule {
        
        struct Authorization {
            static let ApiKey: String = "a2a8bc0497fc94c9201ff86c55259106"
        }

        struct Request {
            static let hostname: URL = URL(string: "https://api.vagalume.com.br/")!
            
            struct Endpoint {
                static let search: String = "search.php"
            }
        }
    }
    
    struct Syncer {
        static let updateTimeout: TimeInterval = 10.0
    }
}
