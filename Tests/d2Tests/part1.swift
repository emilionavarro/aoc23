@testable import d2
import XCTest

final class Day2Tests: XCTestCase {
    func testGameId() throws {
        let day2 = d2()
        XCTAssertEqual(2, day2.parseGameLine("Game 2: 6 blue, 3 green; 4 red, 1 green, 7 blue; 2 green")["game"])
    }

    static var allTests = [
        ("testPart1", testGameId),
    ]
}
