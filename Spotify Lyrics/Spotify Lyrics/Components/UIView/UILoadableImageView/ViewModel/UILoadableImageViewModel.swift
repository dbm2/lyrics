//
//  UILoadableImageViewModel.swift
//  Spotify Lyrics
//
//  Created by Daniel Maranhão on 10/10/19.
//  Copyright © 2019 Daniel Maranhão. All rights reserved.
//

import Foundation
import Combine

final class UILoadableImageViewModel: UILoadableImageViewModelProtocol {
    
    private var subscriber: Cancellable?
    
    func load(from url: URL?, with completion: @escaping (Data) -> Void) {
        subscriber?.cancel()
        
        guard let url = url else { return }
        
        subscriber = HTTP.request(for: url, using: .GET, content: .none)
            .map { $0.data }
            .replaceError(with: Data())
            .receive(on: DispatchQueue.main)
            .sink { (data) in
                completion(data)
            }
    }
}
