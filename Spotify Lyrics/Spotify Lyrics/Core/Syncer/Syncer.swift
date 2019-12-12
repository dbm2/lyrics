//
//  Syncer.swift
//  Spotify Lyrics
//
//  Created by Daniel Maranhão on 10/10/19.
//  Copyright © 2019 Daniel Maranhão. All rights reserved.
//

import Foundation
import Combine

class Syncer<T> where T: Decodable {
    
    private let timeout: TimeInterval
    private let publisher: AnyPublisher<T, Error>
    private let result: (Result<T, Error>) -> Void
    
    private var subscriber: Cancellable?
    private var timer: Timer?
    
    init(with timeout: TimeInterval, and publisher: AnyPublisher<T, Error>, handler result: @escaping (Result<T, Error>) -> Void) {
        self.timeout = timeout
        self.publisher = publisher
        self.result = result
    }
    
    func listen() {
        timer?.invalidate()
        subscriber?.cancel()
        timer = Timer.scheduledTimer(timeInterval: timeout,
                                     target: self,
                                     selector: #selector(fire),
                                     userInfo: nil,
                                     repeats: true)
        timer?.fire()
    }
    
    func stop() {
        timer?.invalidate()
        timer = nil
        subscriber?.cancel()
        subscriber = nil
    }
    
    @objc private func fire() {
        subscriber = publisher.sink(receiveCompletion: { [weak self] (completion) in
            switch completion {
            case .failure(let error):
                self?.result(.failure(error))
            default:
                break
            }
        }, receiveValue: { [weak self] object in
            self?.result(.success(object))
        })
    }
}

