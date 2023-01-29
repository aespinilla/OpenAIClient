//
//  HTTPClient+Publishers.swift
//  
//
//  Created by Alberto Espinilla Garrido on 29/1/23.
//

import Combine
import OpenAIClient

//public extension HTTPClient {
//
//}

//extension HTTPClient {
//    func request<T: Decodable>(request: URLRequest) -> AnyPublisher<T, HTTPClientError> {
//        urlSession.dataTaskPublisher(for: request)
//            .mapError({ HTTPClientError.urlError($0) })
//        // tryMap or flatMap
//            .compactMap({ $0.data })
//            .decode(type: T.self, decoder: decoder)
//            .mapError({ HTTPClientError.decode($0) })
//            .eraseToAnyPublisher()
//    }
//}
//
//private extension HTTPClient {
//
//}

public struct OpenAIClientCombine {}
