import XCTest
import Combine
@testable import OpenAIClient

final class OpenAIClientTests: XCTestCase {
    private var sut: OpenAIClient!
    
    private var cancellables: Set<AnyCancellable> = .init()
    
    override func tearDownWithError() throws {
        sut = nil
    }
    
    // MARK: - Completion
    
    func testGivenPromptWhenCompletionWithCallbackThenMatch() throws {
        let completion = CompletionBuilder().build()
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
        let completion = CompletionBuilder().build()
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
        let completion = CompletionBuilder().build()
        let httpClientMock: HTTPClientMock<Completion> = initialize()
        httpClientMock.resultMock = .success(completion)
        let request = CompletionRequest(prompt: "lorem ipsum")
        let output = try? await sut.completion(request: request)
        XCTAssertEqual(try XCTUnwrap(output), completion)
        XCTAssertEqual(httpClientMock.requestTimes, 1)
    }
    
    // MARK: - Edits
    
    func testGivenEditRequestWhenEditWithCallbackThenMatch() throws {
        let edit = EditBuilder().build()
        let httpClientMock: HTTPClientMock<Edit> = initialize()
        httpClientMock.resultMock = .success(edit)
        let request = EditRequest(instruction: "lorem ipsum")
        let expectation = expectation(description: #function)
        var output: Result<Edit, OpenAIError>?
        sut.edits(request: request, completion: { output = $0; expectation.fulfill() })
        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(try XCTUnwrap(output), .success(edit))
        XCTAssertEqual(httpClientMock.requestTimes, 1)
    }
    
    func testGivenEditRequestWhenEditWithPublisherThenMatch() throws {
        let edit = EditBuilder().build()
        let httpClientMock: HTTPClientMock<Edit> = initialize()
        httpClientMock.publisherMock = CurrentValueSubject(edit).eraseToAnyPublisher()
        let request = EditRequest(instruction: "lorem ipsum")
        let expectation = expectation(description: #function)
        var output: Edit?
        sut.edits(request: request)
            .sink(receiveCompletion: { _ in }, receiveValue: { output = $0; expectation.fulfill() })
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(try XCTUnwrap(output), edit)
        XCTAssertEqual(httpClientMock.requestPublisherTimes, 1)
    }
    
    func testGivenEditRequestWhenEditWithAsyncThenMatch() async throws {
        let edit = EditBuilder().build()
        let httpClientMock: HTTPClientMock<Edit> = initialize()
        httpClientMock.resultMock = .success(edit)
        let request = EditRequest(instruction: "lorem ipsum")
        let output = try? await sut.edits(request: request)
        XCTAssertEqual(try XCTUnwrap(output), edit)
        XCTAssertEqual(httpClientMock.requestTimes, 1)
    }
    
    // MARK: - Images
    
    func testGivenPromptWhenImageCreatedWithCallbackThenMatch() throws {
        let image = ImageBuilder().build()
        let httpClientMock: HTTPClientMock<Image> = initialize()
        httpClientMock.resultMock = .success(image)
        let request = ImageCreateRequest(prompt: "lorem ipsum")
        let expectation = expectation(description: #function)
        var output: Result<Image, OpenAIError>?
        sut.image(request: request, completion: { output = $0; expectation.fulfill() })
        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(try XCTUnwrap(output), .success(image))
        XCTAssertEqual(httpClientMock.requestTimes, 1)
    }
    
    func testGivenPromptWhenImageCreateWithPublisherThenMatch() throws {
        let image = ImageBuilder().build()
        let httpClientMock: HTTPClientMock<Image> = initialize()
        httpClientMock.publisherMock = CurrentValueSubject(image).eraseToAnyPublisher()
        let request = ImageCreateRequest(prompt: "lorem ipsum")
        let expectation = expectation(description: #function)
        var output: Image?
        sut.image(request: request)
            .sink(receiveCompletion: { _ in }, receiveValue: { output = $0; expectation.fulfill() })
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(try XCTUnwrap(output), image)
        XCTAssertEqual(httpClientMock.requestPublisherTimes, 1)
    }
    
    func testGivenPromptWhenImageCreateWithAsyncThenMatch() async throws {
        let image = ImageBuilder().build()
        let httpClientMock: HTTPClientMock<Image> = initialize()
        httpClientMock.resultMock = .success(image)
        let request = ImageCreateRequest(prompt: "lorem ipsum")
        let output = try? await sut.image(request: request)
        XCTAssertEqual(try XCTUnwrap(output), image)
        XCTAssertEqual(httpClientMock.requestTimes, 1)
    }
    
    // MARK: - Moderations
    
    func testGivenInputWhenModerationsWithCallbackThenMatch() throws {
        let moderation = ModerationBuilder().build()
        let httpClientMock: HTTPClientMock<Moderation> = initialize()
        httpClientMock.resultMock = .success(moderation)
        let request = ModerationRequest(input: "lorem ipsum some body text")
        let expectation = expectation(description: #function)
        var output: Result<Moderation, OpenAIError>?
        sut.moderations(request: request, completion: { output = $0; expectation.fulfill() })
        wait(for: [expectation], timeout: 1)
        XCTAssertEqual(try XCTUnwrap(output), .success(moderation))
        XCTAssertEqual(httpClientMock.requestTimes, 1)
    }
    
    func testGivenInputWhenModerationsWithPublisherThenMatch() throws {
        let moderation = ModerationBuilder().build()
        let httpClientMock: HTTPClientMock<Moderation> = initialize()
        httpClientMock.publisherMock = CurrentValueSubject(moderation).eraseToAnyPublisher()
        let request = ModerationRequest(input: "lorem ipsum some body text")
        let expectation = expectation(description: #function)
        var output: Moderation?
        sut.moderations(request: request)
            .sink(receiveCompletion: { _ in }, receiveValue: { output = $0; expectation.fulfill() })
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(try XCTUnwrap(output), moderation)
        XCTAssertEqual(httpClientMock.requestPublisherTimes, 1)
    }
    
    func testGivenInputWhenModerationsWithAsyncThenMatch() async throws {
        let moderation = ModerationBuilder().build()
        let httpClientMock: HTTPClientMock<Moderation> = initialize()
        httpClientMock.resultMock = .success(moderation)
        let request = ModerationRequest(input: "lorem ipsum some body text")
        let output = try? await sut.moderations(request: request)
        XCTAssertEqual(try XCTUnwrap(output), moderation)
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
