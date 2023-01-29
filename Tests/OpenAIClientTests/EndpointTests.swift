//
//  EndpointTests.swift
//  
//
//  Created by Alberto Espinilla Garrido on 29/1/23.
//

import XCTest
@testable import OpenAIClient

final class EndpointTests: XCTestCase {

    func testGivenDefaultWhenInitThenMatch() throws {
        [
            Test(input: Endpoint.completion(), output: (path: "/v1/completions", method: "POST")),
            Test(input: Endpoint.edit(), output: (path: "/v1/edits", method: "POST")),
            Test(input: Endpoint.image(), output: (path: "/v1/images/generations", method: "POST"))
        ].forEach({
            XCTAssertEqual($0.input.path, $0.output.path)
            XCTAssertEqual($0.input.method.rawValue, $0.output.method)
        })
    }
    
    func testGivenVersionWhenInitThenMatch() throws {
        let version = Version.custom(version: "xx")
        [
            Test(input: Endpoint.completion(version: version), output: (path: "/\(version.version)/completions", method: "POST")),
            Test(input: Endpoint.edit(version: version), output: (path: "/\(version.version)/edits", method: "POST")),
            Test(input: Endpoint.image(version: version), output: (path: "/\(version.version)/images/generations", method: "POST"))
        ].forEach({
            XCTAssertEqual($0.input.path, $0.output.path)
            XCTAssertEqual($0.input.method.rawValue, $0.output.method)
        })
    }

}
