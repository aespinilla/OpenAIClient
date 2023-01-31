import XCTest
import Combine
@testable import OpenAIClient

final class OpenAIClientTests: XCTestCase {
    private var sut: OpenAIClient!
    
    private var cancellables: Set<AnyCancellable> = .init()
    
    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testGivenPromptWhenCompletionWithCallbackThenMatch() throws {
        let completion = Completion(id: "",
                                    object: "",
                                    created: Date(),
                                    model: "",
                                    choices: [],
                                    usage: .init(promptTokens: 0, completionTokens: 0, totalTokens: 0))
        let httpClientMock: HTTPClientMock<Completion> = initialize()
        httpClientMock.resultMock = .success(completion)
        let request = CompletionRequest(prompt: "lorem ipsum")
        let expectation = expectation(description: #function)
        var output: Result<Completion, OpenAIError>?
        sut.completion(request: request, completion: { output = $0; expectation.fulfill() })
        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(try XCTUnwrap(output), .success(completion))
        XCTAssertEqual(httpClientMock.requestTimes, 1)
    }
    
    func testGivenPromptWhenCompletionWithPublisherThenMatch() throws {
        let completion = Completion(id: "",
                                    object: "",
                                    created: Date(),
                                    model: "",
                                    choices: [],
                                    usage: .init(promptTokens: 0, completionTokens: 0, totalTokens: 0))
        let httpClientMock: HTTPClientMock<Completion> = initialize()
        httpClientMock.publisherMock = CurrentValueSubject(completion).eraseToAnyPublisher()
        let request = CompletionRequest(prompt: "lorem ipsum")
        let expectation = expectation(description: #function)
        var output: Completion?
        sut.completion(request: request)
            .sink(receiveCompletion: { _ in }, receiveValue: { output = $0; expectation.fulfill() })
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(try XCTUnwrap(output), completion)
        XCTAssertEqual(httpClientMock.requestPublisherTimes, 1)
    }
    
    func testGivenPromptWhenCompletionWithAsyncThenMatch() async throws {
        let completion = Completion(id: "",
                                    object: "",
                                    created: Date(),
                                    model: "",
                                    choices: [],
                                    usage: .init(promptTokens: 0, completionTokens: 0, totalTokens: 0))
        let httpClientMock: HTTPClientMock<Completion> = initialize()
        httpClientMock.resultMock = .success(completion)
        let request = CompletionRequest(prompt: "lorem ipsum")
        let output = try? await sut.completion(request: request)
        XCTAssertEqual(try XCTUnwrap(output), completion)
        XCTAssertEqual(httpClientMock.requestTimes, 1)
    }
}

private extension OpenAIClientTests {
    func initialize<T: Decodable>() -> HTTPClientMock<T> {
        let httpClientMock = HTTPClientMock<T>()
        sut = .init(httpClient: httpClientMock)
        return httpClientMock
    }
}
