//
//  HTTPAuthorization.swift
//  Spotify Lyrics
//
//  Created by Daniel Maranhão on 10/10/19.
//  Copyright © 2019 Daniel Maranhão. All rights reserved.
//

import Foundation

enum HTTPAuthorization {
    case bearer(auth: String)
    
    var value: String {
        switch self {
        case .bearer(let token):
          return "Bearer \(token)"
        }
    }
}
