//
//  Track.swift
//  Spotify Lyrics
//
//  Created by Daniel Maranhão on 10/10/19.
//  Copyright © 2019 Daniel Maranhão. All rights reserved.
//

import Foundation

struct Track: Decodable {
    let id: String
    let name: String
    let artists: [Artist]
    let album: Album
   
    enum CodingKeys: String, CodingKey {
         case id, name, artists, album
     }
}
