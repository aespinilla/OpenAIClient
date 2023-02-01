//
//  OpenAIURLMock.swift
//  
//
//  Created by Alberto Espinilla Garrido on 29/1/23.
//

import Foundation
@testable import OpenAIClient

class OpenAIURLMock: OpenAIURL {
    private(set) var urlTimes: Int = 0
    var mockUrl: String = ""
    
    var url: String {
        urlTimes += 1
        return mockUrl
    }
    
    func reset() {
        urlTimes = 0
        mockUrl = ""
    }
}
