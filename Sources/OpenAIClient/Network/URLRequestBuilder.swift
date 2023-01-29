//
//  URLRequestBuilder.swift
//  
//
//  Created by Alberto Espinilla Garrido on 29/1/23.
//

import Foundation

struct URLRequestBuilder {
    private let openAIURL: OpenAIURL
    private let encoder: JSONEncoder
    private let token: String
    
    init(openAIURL: OpenAIURL = DefaultOpenAIURL(), encoder: JSONEncoder = .init(), token: String) {
        self.openAIURL = openAIURL
        self.encoder = encoder
        self.token = token
    }
    
    func build<T: Encodable>(endpoint: Endpoint, body: T) -> URLRequest? {
        guard let url = URL(string: openAIURL.url + endpoint.path)
        else { return nil }
        
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
        urlComponents?.path = endpoint.path
        
        guard let urlComponentsUrl = urlComponents?.url
        else { return nil }
        
        var request = URLRequest(url: urlComponentsUrl)
        request.httpMethod = endpoint.method.rawValue
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-type")
        request.httpBody = try? encoder.encode(body)
        request.timeoutInterval = 120
        return request
    }
}
