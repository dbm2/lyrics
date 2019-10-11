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

//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        id = try values.decode(String.self, forKey: .id)
//        name = try values.decode(String.self, forKey: .name)
//        artists = try values.decode(Artist.self, forKey: .artists)
//        album = try values.decode(Album.self, forKey: .album)
//    }
}
