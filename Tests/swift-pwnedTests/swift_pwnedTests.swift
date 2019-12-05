import XCTest
@testable import swift_pwned
import Vapor

final class swift_pwnedTests: XCTestCase {
    func testClient() throws {
        let application = try Application()
        let client = try PwnedClient(client: application.client())
        
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
        XCTAssert(try client.pwned(password: "password").wait())
    }

    static var allTests = [
        ("testClient", testClient),
    ]
}
