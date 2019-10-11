//
//  HTTP.swift
//  Spotify Lyrics
//
//  Created by Daniel Maranhão on 10/10/19.
//  Copyright © 2019 Daniel Maranhão. All rights reserved.
//

import Foundation
import Combine

final class HTTP {
    
    static func request(for url: URL,
                        using method: HTTPMethod,
                        content type: HTTPContentType,
                        authorization: HTTPAuthorization? = nil) -> URLSession.DataTaskPublisher {
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.addValue(type.rawValue, forHTTPHeaderField: "Content-Type")
        if let authorization = authorization {
            request.addValue(authorization.value, forHTTPHeaderField: "Authorization")
        }
        
        return URLSession.shared.dataTaskPublisher(for: request)
    }
    
    static func request<T>(for url: URL,
                           using method: HTTPMethod,
                           content type: HTTPContentType,
                           authorization: HTTPAuthorization? = nil) -> AnyPublisher<T, Error> where T: Decodable {
        return request(for: url, using: method, content: type, authorization: authorization)
            .map { $0.data }
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
