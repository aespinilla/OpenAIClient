//
//  OpenAIURLMock.swift
//  
//
//  Created by Alberto Espinilla Garrido on 29/1/23.
//

import Foundation
@testable import OpenAIClient

class OpenAIURLMock: OpenAIURL {
    private(set) var url: String
    
    init(url: String = "https://fake.url") {
        self.url = url
    }
}
