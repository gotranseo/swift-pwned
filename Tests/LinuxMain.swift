import XCTest

import swift_pwnedTests

var tests = [XCTestCaseEntry]()
tests += swift_pwnedTests.allTests()
XCTMain(tests)
