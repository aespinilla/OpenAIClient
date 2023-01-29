//
//  Version.swift
//  
//
//  Created by Alberto Espinilla Garrido on 29/1/23.
//

import Foundation

public enum Version {
    case v1
    case custom(version: String)
    
    var version: String {
        switch self {
        case .v1: return "v1"
        case let .custom(version): return version
        }
    }
}
