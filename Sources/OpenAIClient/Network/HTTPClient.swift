//
//  HTTPClient.swift
//  
//
//  Created by Alberto Espinilla Garrido on 29/1/23.
//

import Foundation

protocol HTTPClient {
    func request<Input: Encodable, Output: Decodable>(endpoint: Endpoint, body: Input, completion: @escaping (Result<Output, OpenAIError>) -> Void)
    
    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    func request<Input: Encodable, Output: Decodable>(endpoint: Endpoint, body: Input) -> AnyPublisher<Output, OpenAIError>
    func requestStream<Input: Encodable, Output: Decodable>(endpoint: Endpoint, body: Input) -> AnyPublisher<Output, OpenAIError>
}

struct HTTPClientImpl: HTTPClient {
    private let urlSessionFactory: URLSessionFactory
    private let urlRequestBuilder: URLRequestBuilder
    private let decoder: JSONDecoder
    
    init(urlSessionFactory: URLSessionFactory = URLSessionFactoryImpl(), urlRequestBuilder: URLRequestBuilder, decoder: JSONDecoder = .default) {
        self.urlSessionFactory = urlSessionFactory
        self.urlRequestBuilder = urlRequestBuilder
        self.decoder = decoder
    }
}

extension HTTPClientImpl {
    func request<Input: Encodable, Output: Decodable>(endpoint: Endpoint, body: Input, completion: @escaping (Result<Output, OpenAIError>) -> Void) {
        guard let urlRequest = urlRequestBuilder.build(endpoint: endpoint, body: body) else {
            return completion(.failure(.urlError))
        }
        let urlSession = urlSessionFactory.shared
        let task = urlSession.dataTask(with: urlRequest, completionHandler: { data, response, error in
            if let _ = error as? URLError {
                return completion(.failure(.urlError))
            }
            
            guard let data = data else {
                return completion(.failure(.noData))
            }
            
            do {
                let output = try self.decoder.decode(Output.self, from: data)
                return completion(.success(output))
            } catch {
                return completion(.failure(.decode))
            }
            
        })
        
        task.resume()
    }
}

#if canImport(Combine)
import Combine

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
extension HTTPClientImpl {
    
    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    func request<Input: Encodable, Output: Decodable>(endpoint: Endpoint, body: Input) -> AnyPublisher<Output, OpenAIError> {
        guard let urlRequest = urlRequestBuilder.build(endpoint: endpoint, body: body) else {
            return Fail(error: .urlError).eraseToAnyPublisher()
        }
        let urlSession = urlSessionFactory.shared
        return urlSession.dataTaskPublisher(for: urlRequest)
            .mapError({ _ in OpenAIError.urlError })
            .compactMap({
                $0.data
            })
            .decode(type: Output.self, decoder: decoder)
            .mapError({ _ in OpenAIError.decode })
            .eraseToAnyPublisher()
    }
    
    func requestStream<Input: Encodable, Output: Decodable>(endpoint: Endpoint, body: Input) -> AnyPublisher<Output, OpenAIError> {
        guard let urlRequest = urlRequestBuilder.build(endpoint: endpoint, body: body) else {
            return Fail(error: .urlError).eraseToAnyPublisher()
        }
        let streamSubject: PassthroughSubject<Output, OpenAIError> = .init()
        let eventSource = EventSource(urlRequest: urlRequest, urlSessionFactory: urlSessionFactory)
        eventSource.onMessage({ _, _, data in
            guard let data = data?.data(using: .utf8),
                  let decoded = try? decoder.decode(Output.self, from: data)
            else { return }
            streamSubject.send(decoded)
        })
        eventSource.onComplete({ _, _, _ in
            streamSubject.send(completion: .finished)
            eventSource.disconnect()
        })
        eventSource.connect()
        return streamSubject.eraseToAnyPublisher()
    }
}
#endif
