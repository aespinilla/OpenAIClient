//
//  HTTPClientMock.swift
//  
//
//  Created by Alberto Espinilla Garrido on 29/1/23.
//

import Foundation
import Combine
@testable import OpenAIClient

final class HTTPClientMock<T: Decodable>: HTTPClient {    
    private(set) var requestTimes: Int = 0
    private(set) var requestPublisherTimes: Int = 0
    private(set) var endpoint: Endpoint?
    private(set) var body: Encodable?
    
    var resultMock: Result<T, OpenAIError>?
    var publisherMock: AnyPublisher<T, OpenAIError> = Empty().eraseToAnyPublisher()
    
    func request<Input: Encodable, Output: Decodable>(endpoint: Endpoint, body: Input, completion: @escaping (Result<Output, OpenAIError>) -> Void) {
        requestTimes += 1
        self.endpoint = endpoint
        self.body = body
        completion(resultMock as! Result<Output, OpenAIError>)
    }
    
    func request<Input: Encodable, Output: Decodable>(endpoint: Endpoint, body: Input) -> AnyPublisher<Output, OpenAIError> {
        requestPublisherTimes += 1
        self.endpoint = endpoint
        self.body = body
        return publisherMock.compactMap({ $0 as? Output }).eraseToAnyPublisher()
    }
    
    func requestStream<Input: Encodable, Output: Decodable>(endpoint: Endpoint, body: Input) -> AnyPublisher<Output, OpenAIError> {
        Empty().eraseToAnyPublisher()
    }
}
