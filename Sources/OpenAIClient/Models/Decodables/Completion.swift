//
//  Completion.swift
//  
//
//  Created by Alberto Espinilla Garrido on 29/1/23.
//

import Foundation

public struct Completion: Decodable, Equatable {
    public struct Choice: Decodable, Equatable {
        public let text: String
        public let index: Int
        public let finishReason: String?
        
        enum CodingKeys: String, CodingKey {
            case text, index
            case finishReason = "finish_reason"
        }
    }
    
    public let id: String
    public let object: String
    public let created: Date
    public let model: String
    public let choices: [Choice]
    public let usage: Usage?
}
