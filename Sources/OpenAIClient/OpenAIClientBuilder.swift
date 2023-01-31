//
//  OpenAIClientBuilder.swift
//  
//
//  Created by Alberto Espinilla Garrido on 29/1/23.
//

import Foundation

public enum OpenAIClientBuilder {
    public static func build(authToken: String) -> OpenAIClient {
        let urlRequestBuilder = URLRequestBuilderImpl(token: authToken)
        let httpClient = HTTPClientImpl(urlRequestBuilder: urlRequestBuilder)
        return .init(httpClient: httpClient)
    }
}
