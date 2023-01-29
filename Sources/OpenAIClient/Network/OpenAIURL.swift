//
//  OpenAIURL.swift
//  
//
//  Created by Alberto Espinilla Garrido on 29/1/23.
//

import Foundation

protocol OpenAIURL {
    var url: String { get }
}

struct DefaultOpenAIURL: OpenAIURL {
    let url: String = "https://api.openai.com"
}
