import Foundation

public struct OpenAIClient {
    internal let httpClient: HTTPClient

    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }
}

public extension OpenAIClient {
    func completion(request: CompletionRequest, version: Version = .v1, completion: @escaping (Result<Completion, OpenAIError>) -> Void) {
        httpClient.request(endpoint: .completion(version: version), body: request, completion: completion)
    }
    
    func edits(request: EditRequest, version: Version = .v1, completion: @escaping (Result<Completion, OpenAIError>) -> Void) {
        httpClient.request(endpoint: .edit(version: version), body: request, completion: completion)
    }
    
    func image(request: ImageCreateRequest, version: Version = .v1, completion: @escaping (Result<Completion, OpenAIError>) -> Void) {
        httpClient.request(endpoint: .image(version: version), body: request, completion: completion)
    }
}