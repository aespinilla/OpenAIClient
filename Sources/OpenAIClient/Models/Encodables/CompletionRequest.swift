//
//  CompletionRequest.swift
//  
//
//  Created by Alberto Espinilla Garrido on 29/1/23.
//

import Foundation

public struct CompletionRequest: Encodable {
    public let tokensPrompt: [Int]?
    public let prompt: String?
    public let model: OpenAIModelType
    public let maxTokens: Int
    
    enum CodingKeys: String, CodingKey {
        case prompt
        case model
        case maxTokens = "max_tokens"
    }
    
    public init(prompt: String, model: OpenAIModelType = .gpt3(.davinci), maxTokens: Int = 3000) {
        self.tokensPrompt = nil
        self.prompt = prompt
        self.model = model
        self.maxTokens = maxTokens
    }
    
    public init(prompt tokensPrompt: [Int], model: OpenAIModelType = .gpt3(.davinci), maxTokens: Int = 3000) {
        self.tokensPrompt = tokensPrompt
        self.prompt = nil
        self.model = model
        self.maxTokens = maxTokens
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(model.modelName, forKey: .model)
        try container.encode(maxTokens, forKey: .maxTokens)
        if let prompt = prompt {
            try container.encode(prompt, forKey: .prompt)
        } else if let tokensPrompt = tokensPrompt {
            try container.encode(tokensPrompt, forKey: .prompt)
        }
    }
}
