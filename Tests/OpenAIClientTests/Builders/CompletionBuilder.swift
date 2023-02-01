//
//  CompletionBuilder.swift
//  
//
//  Created by Alberto Espinilla Garrido on 31/1/23.
//

import Foundation
@testable import OpenAIClient

final class CompletionBuilder {
    private var id: String = ""
    private var object: String = ""
    private var created: Date = Date()
    private var model: String = ""
    private var choices: [Completion.Choice] = [CompletionChoiceBuilder().build()]
    private var usage: Usage = UsageBuilder().build()
    
    func id(_ params: String) -> Self {
        id = params
        return self
    }
    
    func object(_ params: String) -> Self {
        object = params
        return self
    }
    
    func created(_ params: Date) -> Self {
        created = params
        return self
    }
    
    func model(_ params: String) -> Self {
        model = params
        return self
    }
    
    func choices(_ params: [Completion.Choice]) -> Self {
        choices = params
        return self
    }
    
    func usage(_ params: Usage) -> Self {
        usage = params
        return self
    }
    
    func build() -> Completion {
        .init(id: id,
              object: object,
              created: created,
              model: model,
              choices: choices,
              usage: usage)
    }
}

final class CompletionChoiceBuilder {
    private var text: String = ""
    private var index: Int = 0
    private var finishReason: String?
    
    func text(_ params: String) -> Self {
        text = params
        return self
    }
    
    func index(_ params: Int) -> Self {
        index = params
        return self
    }
    
    func finishReason(_ params: String?) -> Self {
        finishReason = params
        return self
    }
    
    func build() -> Completion.Choice {
        .init(text: text,
              index: index,
              finishReason: finishReason)
    }
}
