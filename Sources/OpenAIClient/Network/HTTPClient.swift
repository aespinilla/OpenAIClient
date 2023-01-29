//
//  HTTPClient.swift
//  
//
//  Created by Alberto Espinilla Garrido on 29/1/23.
//

import Foundation

internal struct HTTPClient {
    private let urlSession: URLSession
    private let urlRequestBuilder: URLRequestBuilder
    private let decoder: JSONDecoder
    
    init(urlSession: URLSession = .shared, urlRequestBuilder: URLRequestBuilder, decoder: JSONDecoder = .default) {
        self.urlSession = urlSession
        self.urlRequestBuilder = urlRequestBuilder
        self.decoder = decoder
    }
}

extension HTTPClient {
    func request<Input: Encodable, Output: Decodable>(endpoint: Endpoint, body: Input, completion: @escaping (Result<Output, OpenAIError>) -> Void) {
        guard let urlRequest = urlRequestBuilder.build(endpoint: endpoint, body: body) else {
            return completion(.failure(.request))
        }
        
        let task = urlSession.dataTask(with: urlRequest, completionHandler: { data, response, error in
            if let urlError = error as? URLError {
                return completion(.failure(.urlError(urlError)))
            }
            
            guard let data = data else {
                return completion(.failure(.noData))
            }
            
            do {
                let output = try decoder.decode(Output.self, from: data)
                return completion(.success(output))
            } catch(let error) {
                return completion(.failure(.decode(error)))
            }
            
        })
        
        task.resume()
    }
}
