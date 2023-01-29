//
//  CompletionRequest.swift
//  
//
//  Created by Alberto Espinilla Garrido on 29/1/23.
//

import Foundation

public struct CompletionRequest: Encodable {
    public let prompt: String
    public let model: OpenAIModelType
    public let maxTokens: Int
    
    enum CodingKeys: String, CodingKey {
        case prompt
        case model
        case maxTokens = "max_tokens"
    }
    
    public init(prompt: String, model: OpenAIModelType = .gpt3(.davinci), maxTokens: Int = 16) {
        self.prompt = prompt
        self.model = model
        self.maxTokens = maxTokens
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(prompt, forKey: .prompt)
        try container.encode(model.modelName, forKey: .model)
        try container.encode(maxTokens, forKey: .maxTokens)
    }
}
