//
//  UsageBuilder.swift
//  
//
//  Created by Alberto Espinilla Garrido on 31/1/23.
//

import Foundation
@testable import OpenAIClient

final class UsageBuilder {
    private var promptTokens: Int = 0
    private var completionTokens: Int = 0
    private var totalTokens: Int = 0
    
    func promptTokens(_ params: Int) -> Self {
        promptTokens = params
        return self
    }
    
    func completionTokens(_ params: Int) -> Self {
        completionTokens = params
        return self
    }
    
    func totalTokens(_ params: Int) -> Self {
        totalTokens = params
        return self
    }
    
    func build() -> Usage {
        .init(promptTokens: promptTokens,
              completionTokens: completionTokens,
              totalTokens: totalTokens)
    }
}
