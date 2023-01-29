//
//  HTTPClientTests.swift
//  
//
//  Created by Alberto Espinilla Garrido on 29/1/23.
//

import XCTest
import Combine
@testable import OpenAIClient

final class HTTPClientTests: XCTestCase {
    
    private let urlRequestBuilderMock: URLRequestBuilderMock<SampleBody> = .init()
    private var sut: HTTPClient!
    
    private var cancellables: Set<AnyCancellable> = .init()

    override func setUpWithError() throws {
        sut = HTTPClient(urlSession: URLSessionMockFactory.default, urlRequestBuilder: urlRequestBuilderMock)
    }

    override func tearDownWithError() throws {
        urlRequestBuilderMock.reset()
        sut = nil
    }

    func testGivenEndpointAndBodyWhenRequestThenMatchCompletion() throws {
        let endpoint = Endpoint.completion()
        let url: URL = try XCTUnwrap(URL(string: endpoint.path))
        urlRequestBuilderMock.urlRequestMock = URLRequest(url: url)
        URLSessionMock.response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)
        let sampleOutput = SampleOutput()
        URLSessionMock.data = sampleOutput.data()
        let body = SampleBody()
        let expectation = expectation(description: #function)
        var output: Result<SampleOutput, OpenAIError>?
        sut.request(endpoint: endpoint, body: body, completion: { output = $0; expectation.fulfill() })
        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(try XCTUnwrap(output), .success(sampleOutput))
    }
    
    func testGivenEndpointAndBodyWhenRequestThenMatchOutput() throws {
        let endpoint = Endpoint.completion()
        let url: URL = try XCTUnwrap(URL(string: endpoint.path))
        urlRequestBuilderMock.urlRequestMock = URLRequest(url: url)
        URLSessionMock.response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)
        let sampleOutput = SampleOutput()
        URLSessionMock.data = sampleOutput.data()
        let body = SampleBody()
        let expectation = expectation(description: #function)
        var output: SampleOutput?
        sut.request(endpoint: endpoint, body: body)
            .sink(receiveCompletion: { _ in }, receiveValue: { output = $0; expectation.fulfill() })
            .store(in: &cancellables)
        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(try XCTUnwrap(output), sampleOutput)
    }
}
