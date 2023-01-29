//
//  OpenAIError.swift
//  
//
//  Created by Alberto Espinilla Garrido on 29/1/23.
//

import Foundation

public enum OpenAIError: Swift.Error {
    case request
    case noData
    case urlError(URLError)
    case decode(Error)
}
