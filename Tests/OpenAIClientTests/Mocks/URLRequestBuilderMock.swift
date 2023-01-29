//
//  URLRequestBuilderMock.swift
//  
//
//  Created by Alberto Espinilla Garrido on 29/1/23.
//

import Foundation
@testable import OpenAIClient

final class URLRequestBuilderMock<T: Encodable>: URLRequestBuilder {
    private(set) var buildTimes: Int = 0
    var urlRequestMock: URLRequest?
    
    private(set) var endpoint: Endpoint?
    private(set) var body: Encodable?
    
    func build<T: Encodable>(endpoint: Endpoint, body: T) -> URLRequest? {
        buildTimes += 1
        self.endpoint = endpoint
        self.body = body
        return urlRequestMock
    }
    
    func reset() {
        buildTimes = 0
        urlRequestMock = nil
        endpoint = nil
        body = nil
    }
}
