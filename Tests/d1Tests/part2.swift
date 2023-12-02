@testable import d1
import XCTest

final class Day2Tests: XCTestCase {
    func testOverlap() throws {
        let day1 = d1()
        XCTAssertEqual(83, day1.getCombinedNumberFromLine(day1.mutateNamedNumbers("eightwothree")))
    }

    func testBetweenDigits() throws {
        let day1 = d1()
        XCTAssertEqual(42, day1.getCombinedNumberFromLine(day1.mutateNamedNumbers("4nineeightseven2")))
    }

    func testLastNumber() throws {
        let day1 = d1()
        XCTAssertEqual(76, day1.getCombinedNumberFromLine(day1.mutateNamedNumbers("7pqrstsixteen")))
    }

    static var allTests = [
        ("testPart1", testOverlap),
        ("testPart2", testBetweenDigits),
        ("testPart3", testLastNumber),
    ]
}
