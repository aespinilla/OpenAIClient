//
//  URLSession+Delegate.swift
//  
//
//  Created by Alberto Espinilla Garrido on 25/2/23.
//

import Foundation

extension URLSession {
    var urlSessionDelegate: URLSessionEventSourceDelegate? {
        delegate as? URLSessionEventSourceDelegate
    }
}
