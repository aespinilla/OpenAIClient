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
    public let stream: Bool
    
    enum CodingKeys: String, CodingKey {
        case prompt
        case model
        case maxTokens = "max_tokens"
        case stream
    }
    
    public init(prompt: String, model: OpenAIModelType = .gpt3(.davinci), maxTokens: Int = 3000, stream: Bool = false) {
        self.tokensPrompt = nil
        self.prompt = prompt
        self.model = model
        self.maxTokens = maxTokens
        self.stream = stream
    }
    
    public init(prompt tokensPrompt: [Int], model: OpenAIModelType = .gpt3(.davinci), maxTokens: Int = 3000, stream: Bool = false) {
        self.tokensPrompt = tokensPrompt
        self.prompt = nil
        self.model = model
        self.maxTokens = maxTokens
        self.stream = stream
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(model.modelName, forKey: .model)
        try container.encode(maxTokens, forKey: .maxTokens)
        try container.encode(stream, forKey: .stream)
        if let prompt = prompt {
            try container.encode(prompt, forKey: .prompt)
        } else if let tokensPrompt = tokensPrompt {
            try container.encode(tokensPrompt, forKey: .prompt)
        }
    }
}

extension CompletionRequest {
    var forceStream: Self {
        if let prompt = prompt {
            return .init(prompt: prompt, model: model, maxTokens: maxTokens, stream: true)
        } else if let tokensPrompt = tokensPrompt {
            return .init(prompt: tokensPrompt, model: model, maxTokens: maxTokens, stream: true)
        }
        return self
    }
}
