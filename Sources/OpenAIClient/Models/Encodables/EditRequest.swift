//
//  EditRequest.swift
//  
//
//  Created by Alberto Espinilla Garrido on 29/1/23.
//

import Foundation

public struct EditRequest: Encodable {
    public let model: OpenAIModelType
    public let instruction: String
    public let input: String
    
    enum CodingKeys: String, CodingKey {
        case model, instruction, input
    }
    
    public init(model: OpenAIModelType = .feature(.davinci), instruction: String, input: String = "") {
        self.model = model
        self.instruction = instruction
        self.input = input
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(model.modelName, forKey: .model)
        try container.encode(instruction, forKey: .instruction)
        try container.encode(input, forKey: .input)
    }
}
