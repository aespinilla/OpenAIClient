//
//  URLSessionFactory.swift
//  
//
//  Created by Alberto Espinilla Garrido on 26/2/23.
//

import Foundation

protocol URLSessionFactory {
    var shared: URLSession { get }
    func stream(configuration: URLSessionConfiguration, delegate: URLSessionEventSourceDelegate, operationQueue: OperationQueue) -> URLSession
}

extension URLSessionFactory {
    var shared: URLSession {
        .shared
    }
}

struct URLSessionFactoryImpl: URLSessionFactory {
    func stream(configuration: URLSessionConfiguration, delegate: URLSessionEventSourceDelegate, operationQueue: OperationQueue) -> URLSession {
        URLSession(configuration: configuration, delegate: delegate, delegateQueue: operationQueue)
    }
}
