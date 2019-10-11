//
//  User.swift
//  Spotify Lyrics
//
//  Created by Daniel Maranhão on 10/10/19.
//  Copyright © 2019 Daniel Maranhão. All rights reserved.
//

import Foundation

struct User: Decodable {
    let name: String?
    let images: [Image]?
    
    private enum CodingKeys : String, CodingKey {
        case name = "display_name"
        case images
    }
}
