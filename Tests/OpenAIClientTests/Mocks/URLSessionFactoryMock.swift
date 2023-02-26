//
//  URLSessionFactoryMock.swift
//  
//
//  Created by Alberto Espinilla Garrido on 26/2/23.
//

import Foundation
@testable import OpenAIClient

final class URLSessionFactoryMock: URLSessionFactory {
    private(set) var sharedTimes: Int = 0
    private(set) var streamTimes: Int = 0
    
    var urlSessionMock: URLSession!
    
    var shared: URLSession {
        sharedTimes += 1
        return urlSessionMock
    }
    
    func stream(configuration: URLSessionConfiguration, delegate: URLSessionEventSourceDelegate, operationQueue: OperationQueue) -> URLSession {
        sharedTimes += 1
        return urlSessionMock
    }
    
    func reset() {
        sharedTimes = 0
        streamTimes = 0
    }
}
