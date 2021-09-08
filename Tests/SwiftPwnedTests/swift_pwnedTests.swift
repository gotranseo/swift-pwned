import XCTest
@testable import SwiftPwned
import Vapor

@available(macOS 12.0.0, *)
final class swift_pwnedTests: XCTestCase {
    func testClient() async throws {
        let application = Application()
        defer { application.shutdown() }
        let client = PwnedClient(client: application.client)
        
        // Test hashing
        let output = try client.generateHash(input: "password")
        let expected = "5BAA61E4C9B93F3F0682250B6CF8331B7EE68FD8"
        XCTAssertEqual(output, expected)
        
        // Test five chars
        let headTail = client.getHeadAndTail(input: expected)
        let five = headTail.head
        let tail = headTail.tail
        let expectedFive = "5BAA6"
        let expectedTail = "1E4C9B93F3F0682250B6CF8331B7EE68FD8"
        
        XCTAssertEqual(expectedFive, five)
        XCTAssertEqual(expectedTail, tail)
        
        // Test get data
        let val = try await client.pwned(password: "password")
        XCTAssert(val)
    }

    static var allTests = [
        ("testClient", testClient),
    ]
}
