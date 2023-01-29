//
//  OpenAIAPIError.swift
//  
//
//  Created by Alberto Espinilla Garrido on 29/1/23.
//

import Foundation

enum OpenAIAPIError: Swift.Error, Equatable {
    case noData
    case urlError
    case decode
}
