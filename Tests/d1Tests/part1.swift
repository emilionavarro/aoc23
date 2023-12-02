@testable import d1
import XCTest

final class Day1Tests: XCTestCase {
    func testSimple() throws {
        let day1 = d1()
        XCTAssertEqual(12, day1.getCombinedNumberFromLine("1abc2"))
    }

    func testOneNumber() throws {
        let day1 = d1()
        XCTAssertEqual(77, day1.getCombinedNumberFromLine("treb7uchet"))
    }

    func testManyNumbers() throws {
        let day1 = d1()
        XCTAssertEqual(15, day1.getCombinedNumberFromLine("a1b2c3d4e5f"))
    }

    static var allTests = [
        ("testPart1", testSimple),
        ("testPart2", testOneNumber),
        ("testPart3", testManyNumbers),
    ]
}
