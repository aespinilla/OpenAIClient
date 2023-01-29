//
//  URLSessionMockFactory.swift
//  
//
//  Created by Alberto Espinilla Garrido on 29/1/23.
//

import Foundation

enum URLSessionMockFactory {
    static var `default`: URLSession = {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [URLSessionMock.self]
        let session = URLSession(configuration: config)
        return session
    }()
}
