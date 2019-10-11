//
//  Album.swift
//  Spotify Lyrics
//
//  Created by Daniel Maranhão on 10/10/19.
//  Copyright © 2019 Daniel Maranhão. All rights reserved.
//

import Foundation

struct Album: Decodable {
    let id: String
    let name: String?
    let images: [Image]?
}
