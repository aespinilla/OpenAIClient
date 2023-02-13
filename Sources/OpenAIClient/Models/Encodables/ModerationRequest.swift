//
//  ModerationRequest.swift
//  
//
//  Created by Alberto Espinilla Garrido on 13/2/23.
//

import Foundation

public struct ModerationRequest: Encodable {
    public let input: String
    public let model: OpenAIModelType
    
    enum CodingKeys: String, CodingKey {
        case input
        case model
    }
    
    public init(input: String, model: OpenAIModelType = .moderations(.latest)) {
        self.input = input
        self.model = model
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(input, forKey: .input)
        try container.encode(model.modelName, forKey: .model)
    }
}
