//
//  Endpoint.swift
//  
//
//  Created by Alberto Espinilla Garrido on 29/1/23.
//

import Foundation

enum Endpoint {
    enum Method: String {
        case get = "GET"
        case post = "POST"
    }
    
    case completion(version: Version = .v1)
    case edit(version: Version = .v1)
    case image(version: Version = .v1)
}

extension Endpoint {
    var path: String {
        switch self {
        case let .completion(version): return "/\(version.version)/completions"
        case let .edit(version): return "/\(version.version)/edits"
        case let .image(version): return "/\(version.version)/images/generations"
        }
    }
    
    var method: Method {
        .post
    }
}
