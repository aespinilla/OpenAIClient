//
//  Edits.swift
//  
//
//  Created by Alberto Espinilla Garrido on 29/1/23.
//

import Foundation

public struct Edit: Decodable {
    public struct Choice: Decodable {
        public let text: String
        public let index: Int
    }
    
    public let object: String
    public let created: Date
    public let choices: [Choice]
    public let usage: Usage
}
