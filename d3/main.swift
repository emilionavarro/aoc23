import Foundation

var seenCoordinates: [(Int, Int)] = []

struct d3 {
    func isSpecialCharacter(_ character: Character) -> Bool {
        return character != "." && !character.isNumber
    }

    func isAsterisk(_ character: Character) -> Bool {
        return character == "*"
    }

    func parseGameLine(_ line: String) -> [String] {
        let gameBoardLine = line.reduce(into: ([String](), "")) { result, character in
            if isSpecialCharacter(character) {
                result.0.append("S")
            }
        }.0
        return gameBoardLine
    }

    func getNumberCoordinatesAroundSpecialTile(_ lineIndex: Int, _ tileIndex: Int, _ gameBoard: [[Character]]) -> [(Int, Int)] {
        var coordinates: [(Int, Int)] = []

        if lineIndex - 1 >= 0 {
            if (gameBoard[lineIndex - 1][tileIndex] as Character).isNumber {
                coordinates.append((lineIndex - 1, tileIndex))
            }

            if tileIndex - 1 >= 0 {
                if (gameBoard[lineIndex - 1][tileIndex - 1] as Character).isNumber {
                    coordinates.append((lineIndex - 1, tileIndex - 1))
                }
            }
            if tileIndex + 1 < gameBoard[lineIndex - 1].count {
                if (gameBoard[lineIndex - 1][tileIndex + 1] as Character).isNumber {
                    coordinates.append((lineIndex - 1, tileIndex + 1))
                }
            }
        }

        if lineIndex + 1 < gameBoard.count {
            if (gameBoard[lineIndex + 1][tileIndex] as Character).isNumber {
                coordinates.append((lineIndex + 1, tileIndex))
            }
            if tileIndex - 1 >= 0 {
                if (gameBoard[lineIndex + 1][tileIndex - 1] as Character).isNumber {
                    coordinates.append((lineIndex + 1, tileIndex - 1))
                }
            }
            if tileIndex + 1 < gameBoard[lineIndex + 1].count {
                if (gameBoard[lineIndex + 1][tileIndex + 1] as Character).isNumber {
                    coordinates.append((lineIndex + 1, tileIndex + 1))
                }
            }
        }

        if tileIndex - 1 >= 0 {
            if (gameBoard[lineIndex][tileIndex - 1] as Character).isNumber {
                coordinates.append((lineIndex, tileIndex - 1))
            }
        }

        if tileIndex + 1 < gameBoard[lineIndex].count {
            if (gameBoard[lineIndex][tileIndex + 1] as Character).isNumber {
                coordinates.append((lineIndex, tileIndex + 1))
            }
        }

        return coordinates
    }

    struct NumberWithCoordinates {
        let number: Int
        let coordinates: [(Int, Int)]
    }

    // create a function that takes a coordinate and a gameboard and finds the multidigit number around it
    func findNumberAroundCoordinate(_ coordinate: (Int, Int), _ gameBoard: [[Character]]) -> NumberWithCoordinates {
        let lineIndex = coordinate.0
        let tileIndex = coordinate.1
        var numberChars = String(gameBoard[lineIndex][tileIndex])
        var coordinates = [(Int, Int)]([(lineIndex, tileIndex)])

        if tileIndex - 1 >= 0 {
            if (gameBoard[lineIndex][tileIndex - 1] as Character).isNumber {
                var walkLeftindex = tileIndex - 1
                while walkLeftindex >= 0 && (gameBoard[lineIndex][walkLeftindex] as Character).isNumber {
                    numberChars = String(gameBoard[lineIndex][walkLeftindex]) + numberChars
                    coordinates.append((lineIndex, walkLeftindex))
                    walkLeftindex -= 1
                }
            }
        }

        if tileIndex + 1 < gameBoard[lineIndex].count {
            if (gameBoard[lineIndex][tileIndex + 1] as Character).isNumber {
                var walkRightindex = tileIndex + 1
                while walkRightindex < gameBoard[lineIndex].count && (gameBoard[lineIndex][walkRightindex] as Character).isNumber {
                    numberChars = numberChars + String(gameBoard[lineIndex][walkRightindex])
                    coordinates.append((lineIndex, walkRightindex))
                    walkRightindex += 1
                }
            }
        }
        return NumberWithCoordinates(number: Int(numberChars) ?? 0, coordinates: coordinates)
    }

    func processGameBoardLine(_ gameBoard: [[Character]]) -> Int {
        var count = 0

        gameBoard.enumerated().forEach { lineIndex, line in
            line.enumerated().forEach { tileIndex, tile in
                if isSpecialCharacter(tile) {
                    let coordinates = getNumberCoordinatesAroundSpecialTile(lineIndex, tileIndex, gameBoard)
                    let numbersToSum = coordinates.map {
                        let numberDetails = findNumberAroundCoordinate($0, gameBoard)
                        if numberDetails.coordinates.count > 0 {
                            if seenCoordinates.contains(where: { $0 == numberDetails.coordinates[0] }) {
                                return 0
                            } else {
                                seenCoordinates.append(contentsOf: numberDetails.coordinates)
                                // print("add number: \(numberDetails.number)")
                                return numberDetails.number
                            }
                        } else {
                            return 0
                        }
                    }
                    count += numbersToSum.reduce(0, +)
                }
            }
        }

        return count
    }

    func processGameBoardLine2(_ gameBoard: [[Character]]) -> Int {
        var count = 0

        gameBoard.enumerated().forEach { lineIndex, line in
            line.enumerated().forEach { tileIndex, tile in
                if isAsterisk(tile) {
                    let coordinates = getNumberCoordinatesAroundSpecialTile(lineIndex, tileIndex, gameBoard)
                    let numbersToMultiply = coordinates.map {
                        let numberDetails = findNumberAroundCoordinate($0, gameBoard)
                        if numberDetails.coordinates.count > 0 {
                            if seenCoordinates.contains(where: { $0 == numberDetails.coordinates[0] }) {
                                return 0
                            } else {
                                seenCoordinates.append(contentsOf: numberDetails.coordinates)
                                // print("add number: \(numberDetails.number)")
                                return numberDetails.number
                            }
                        } else {
                            return 0
                        }
                    }.filter { $0 > 0 }
                    if numbersToMultiply.count == 2 {
                        count += numbersToMultiply.reduce(1, *)
                    }
                }
            }
        }

        return count
    }

    func part1() throws {
        let file = URL(fileURLWithPath: "./d3/data.txt")
        do {
            let data: Data = try Data(contentsOf: file)
            var gameBoard: [[Character]] = []
            if let content = String(data: data, encoding: .utf8) {
                let lines = content.components(separatedBy: "\n")
                gameBoard = lines.map { Array($0) }
                let count = processGameBoardLine(gameBoard)
                print("count: \(count)")
            }
        } catch {
            throw error
        }
    }

    func part2() throws {
        let file = URL(fileURLWithPath: "./d3/data.txt")
        do {
            let data: Data = try Data(contentsOf: file)
            var gameBoard: [[Character]] = []
            if let content = String(data: data, encoding: .utf8) {
                let lines = content.components(separatedBy: "\n")
                gameBoard = lines.map { Array($0) }
                let count = processGameBoardLine2(gameBoard)
                print("count: \(count)")
            }
        } catch {
            throw error
        }
    }
}

let day3 = d3()
// try day3.part1()
try day3.part2()

extension String {
    var isNumber: Bool {
        let digitsCharacters = CharacterSet(charactersIn: "0123456789")
        return CharacterSet(charactersIn: self).isSubset(of: digitsCharacters)
    }
}
