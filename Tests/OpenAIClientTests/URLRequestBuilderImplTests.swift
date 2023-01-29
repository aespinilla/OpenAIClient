//
//  URLRequestBuilderImplTests.swift
//  
//
//  Created by Alberto Espinilla Garrido on 29/1/23.
//

import XCTest
@testable import OpenAIClient

final class URLRequestBuilderImplTests: XCTestCase {
    private static let mockURL = "https://fake.builder"
    private let mockToken = "aabbccddee"
    private let openAIURLMock: OpenAIURLMock = .init(url: mockURL)
    private var sut: URLRequestBuilder!
    
    override func setUpWithError() throws {
        sut = URLRequestBuilderImpl(openAIURL: openAIURLMock, token: mockToken)
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }

    func testGivenEndpointAndBodyWhenBuildThenMatch() throws {
        let endpoint = Endpoint.completion()
        let body = SampleBody()
        let output = sut.build(endpoint: endpoint, body: body)
        XCTAssertNotNil(output)
    }

}
