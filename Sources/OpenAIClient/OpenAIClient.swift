import Foundation

#if canImport(UIKit)
import UIKit
#endif

public struct OpenAIClient {
    private let httpClient: HTTPClient
    
    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }
}

public extension OpenAIClient {
    func completion(request: CompletionRequest, version: Version = .v1, completion: @escaping (Result<Completion, OpenAIError>) -> Void) {
        httpClient.request(endpoint: .completion(version: version), body: request, completion: completion)
    }
    
    func edits(request: EditRequest, version: Version = .v1, completion: @escaping (Result<Edit, OpenAIError>) -> Void) {
        httpClient.request(endpoint: .edit(version: version), body: request, completion: completion)
    }
    
    func image(request: ImageCreateRequest, version: Version = .v1, completion: @escaping (Result<Image, OpenAIError>) -> Void) {
        httpClient.request(endpoint: .image(version: version), body: request, completion: completion)
    }
    
    func moderations(request: ModerationRequest, version: Version = .v1, completion: @escaping (Result<Moderation, OpenAIError>) -> Void) {
        httpClient.request(endpoint: .moderations(version: version), body: request, completion: completion)
    }
    
#if canImport(UIKit)
    func singleImage(prompt: String, size: ImageCreateRequest.Size = .s1024, completion: @escaping (UIImage?) -> Void) {
        let request = ImageCreateRequest(prompt: prompt, size: size, outputType: .base64)
        image(request: request, completion: { completion($0.data.first?.image) })
    }
#endif
}

#if canImport(Combine)
import Combine

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
public extension OpenAIClient {
    
    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    func completion(request: CompletionRequest, version: Version = .v1) -> AnyPublisher<Completion, OpenAIError> {
        httpClient.request(endpoint: .completion(version: version), body: request)
    }
    
    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    func edits(request: EditRequest, version: Version = .v1) -> AnyPublisher<Edit, OpenAIError> {
        httpClient.request(endpoint: .edit(version: version), body: request)
    }
    
    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    func image(request: ImageCreateRequest, version: Version = .v1) -> AnyPublisher<Image, OpenAIError> {
        httpClient.request(endpoint: .image(version: version), body: request)
    }
    
    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    func moderations(request: ModerationRequest, version: Version = .v1) -> AnyPublisher<Moderation, OpenAIError> {
        httpClient.request(endpoint: .moderations(version: version), body: request)
    }
    
    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    func completionStream(request: CompletionRequest, version: Version = .v1) -> AnyPublisher<Completion, OpenAIError> {
        httpClient.requestStream(endpoint: .completion(version: version), body: request.forceStream)
    }
    
#if canImport(UIKit)
//    func singleImage(prompt: String, size: ImageCreateRequest.Size = .s1024) -> AnyPublisher<UIImage?, Never> {
//        let request = ImageCreateRequest(prompt: prompt, size: size, outputType: .base64)
//        return image(request: request)
//            .map({ $0.data.first?.image })
//            .replaceError({ _ in return nil })
//            .eraseToAnyPublisher()
//    }
#endif
}
#endif

public extension OpenAIClient {
    @available(swift 5.5)
    @available(macOS 10.15, iOS 13, watchOS 6, tvOS 13, *)
    func completion(request: CompletionRequest, version: Version = .v1) async throws -> Completion {
        try await withCheckedThrowingContinuation({ continuation in
            httpClient.request(endpoint: .completion(version: version),
                               body: request,
                               completion: { continuation.resume(with: $0) })
        })
    }
    
    @available(swift 5.5)
    @available(macOS 10.15, iOS 13, watchOS 6, tvOS 13, *)
    func edits(request: EditRequest, version: Version = .v1) async throws -> Edit {
        try await withCheckedThrowingContinuation({ continuation in
            httpClient.request(endpoint: .edit(version: version),
                               body: request,
                               completion: { continuation.resume(with: $0) })
        })
    }
    
    @available(swift 5.5)
    @available(macOS 10.15, iOS 13, watchOS 6, tvOS 13, *)
    func image(request: ImageCreateRequest, version: Version = .v1) async throws -> Image {
        try await withCheckedThrowingContinuation({ continuation in
            httpClient.request(endpoint: .image(version: version),
                               body: request,
                               completion: { continuation.resume(with: $0) })
        })
    }
    
    @available(swift 5.5)
    @available(macOS 10.15, iOS 13, watchOS 6, tvOS 13, *)
    func moderations(request: ModerationRequest, version: Version = .v1) async throws -> Moderation {
        try await withCheckedThrowingContinuation({ continuation in
            httpClient.request(endpoint: .moderations(version: version),
                               body: request,
                               completion: { continuation.resume(with: $0) })
        })
    }
    
#if canImport(UIKit)
    func singleImage(prompt: String, size: ImageCreateRequest.Size = .s1024) async -> UIImage? {
        let request = ImageCreateRequest(prompt: prompt, size: size, outputType: .base64)
        let image = try? await image(request: request)
        return image?.data.first?.image
    }
#endif
}
