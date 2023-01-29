import XCTest
@testable import OpenAIClient

final class OpenAIClientTests: XCTestCase {
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(OpenAIClient().text, "Hello, World!")
    }
}
