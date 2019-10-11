//
//  UILoadableImageViewProtocol.swift
//  Spotify Lyrics
//
//  Created by Daniel Maranhão on 10/10/19.
//  Copyright © 2019 Daniel Maranhão. All rights reserved.
//

import Foundation

protocol UILoadableImageViewModelProtocol {
    func load(from url: URL?, with completion: @escaping (Data) -> Void)
}
