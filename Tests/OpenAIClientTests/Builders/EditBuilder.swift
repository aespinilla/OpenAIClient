//
//  EditBuilder.swift
//  
//
//  Created by Alberto Espinilla Garrido on 1/2/23.
//

import Foundation
@testable import OpenAIClient

final class EditBuilder {
    private var object: String = ""
    private var created: Date = Date()
    private var choices: [Edit.Choice] = [EditChoiceBuilder().build()]
    private var usage: Usage = UsageBuilder().build()
    
    func object(_ params: String) -> Self {
        object = params
        return self
    }
    
    func created(_ params: Date) -> Self {
        created = params
        return self
    }
    
    func choices(_ params: [Edit.Choice]) -> Self {
        choices = params
        return self
    }
    
    func usage(_ params: Usage) -> Self {
        usage = params
        return self
    }
    
    func build() -> Edit {
        .init(object: object,
              created: created,
              choices: choices,
              usage: usage)
    }
}

final class EditChoiceBuilder {
    private var text: String = ""
    private var index: Int = 0
    
    func text(_ params: String) -> Self {
        text = params
        return self
    }
    
    func index(_ params: Int) -> Self {
        index = params
        return self
    }
    
    func build() -> Edit.Choice {
        .init(text: text,
              index: index)
    }
}
