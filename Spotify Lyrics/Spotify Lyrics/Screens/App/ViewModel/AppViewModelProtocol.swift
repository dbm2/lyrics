//
//  AppViewModelProtocol.swift
//  Spotify Lyrics
//
//  Created by Daniel Maranhão on 10/10/19.
//  Copyright © 2019 Daniel Maranhão. All rights reserved.
//

import Foundation

protocol AppViewModelProtocol {
    
    var delegate: AppViewModelDelegate? { get set }
    
    func prepareApplication()
}
