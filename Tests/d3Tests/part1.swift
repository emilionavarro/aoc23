@testable import d3
import XCTest

final class Day3Tests: XCTestCase {
    func testCoordinateSearchBasic() throws {
        let aoc = d3()
        let gameboard: [[Character]] = [
            ["*", "1", "."],
            [".", ".", "."],
            [".", "1", "."],
        ]
        XCTAssert(aoc.getNumberCoordinatesAroundSpecialTile(0, 0, gameboard).count == 1)
    }

    func testCoordinateSearchUpDown() throws {
        let aoc = d3()
        let gameboard: [[Character]] = [
            [".", "1", "."],
            [".", "*", "."],
            [".", "1", "."],
        ]
        XCTAssert(aoc.getNumberCoordinatesAroundSpecialTile(1, 1, gameboard).count == 2)
    }

    func testCoordinateSearchAround() throws {
        let aoc = d3()
        let gameboard: [[Character]] = [
            ["1", "1", "1"],
            ["1", "*", "1"],
            ["1", "1", "1"],
        ]
        XCTAssert(aoc.getNumberCoordinatesAroundSpecialTile(1, 1, gameboard).count == 8)
    }

    func testNumberWalkSimple() throws {
        let aoc = d3()
        let gameboard: [[Character]] = [
            [".", "1", "2"],
            ["*", ".", "."],
            [".", ".", "."],
        ]
        let numberFound = aoc.findNumberAroundCoordinate((0, 1), gameboard)
        XCTAssert(numberFound.number == 12)
    }

    static var allTests = [
        ("testUpper", testCoordinateSearchBasic),
        ("testCoordinateSearchUpDown", testCoordinateSearchUpDown),
        ("testCoordinateSearchAround", testCoordinateSearchAround),
    ]
}
