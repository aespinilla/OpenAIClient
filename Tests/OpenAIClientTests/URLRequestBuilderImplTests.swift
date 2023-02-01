//
//  URLRequestBuilderImplTests.swift
//  
//
//  Created by Alberto Espinilla Garrido on 29/1/23.
//

import XCTest
@testable import OpenAIClient

final class URLRequestBuilderImplTests: XCTestCase {
    private let mockURL = "https://fake.builder"
    private let mockToken = "aabbccddee"
    private let openAIURLMock: OpenAIURLMock = .init()
    private var sut: URLRequestBuilder!
    
    override func setUpWithError() throws {
        openAIURLMock.mockUrl = mockURL
        sut = URLRequestBuilderImpl(openAIURL: openAIURLMock, token: mockToken)
    }
    
    override func tearDownWithError() throws {
        openAIURLMock.reset()
        sut = nil
    }

    func testGivenEndpointAndBodyWhenBuildThenMatch() throws {
        let endpoint = Endpoint.completion()
        let body = SampleBody()
        let expected = try buildURLRequest(endpoint: endpoint, body: body)
        let output = sut.build(endpoint: endpoint, body: body)
        XCTAssertEqual(output, expected)
        XCTAssertEqual(openAIURLMock.urlTimes, 1)
    }

    func testGivenInvalidUrlWhenBuildThenMatchError() throws {
        let endpoint = Endpoint.completion()
        let body = SampleBody()
        openAIURLMock.mockUrl = ""
        let output = sut.build(endpoint: endpoint, body: body)
        XCTAssertNil(output)
        XCTAssertEqual(openAIURLMock.urlTimes, 1)
    }
}

private extension URLRequestBuilderImplTests {
    func buildURLRequest(endpoint: Endpoint, body: Encodable) throws -> URLRequest? {
        let url = try XCTUnwrap(URL(string: openAIURLMock.mockUrl))
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
        urlComponents?.path = endpoint.path
        let urlComponentsUrl = try XCTUnwrap(urlComponents?.url)
        var request = URLRequest(url: urlComponentsUrl)
        request.httpMethod = endpoint.method.rawValue
        request.setValue("Bearer \(mockToken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-type")
        request.httpBody = body.data()
        request.timeoutInterval = 120
        return request
    }
}
