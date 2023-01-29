//
//  OpenAIClient+Combine.swift
//  
//
//  Created by Alberto Espinilla Garrido on 29/1/23.
//

#if canImport(Combine)

import Combine
import OpenAIClient

public extension OpenAIClient {
    func completion(request: CompletionRequest) -> AnyPublisher<Completion, OpenAIError> {
        Empty().eraseToAnyPublisher()
    }
    
    func edits(request: EditRequest) -> AnyPublisher<Edit, OpenAIError> {
        Empty().eraseToAnyPublisher()
    }
    
    func image(request: ImageCreateRequest) -> AnyPublisher<Image, OpenAIError> {
        Empty().eraseToAnyPublisher()
    }
}

#endif
