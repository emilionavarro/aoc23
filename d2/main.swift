import Foundation

let config = [
    "red": 12,
    "green": 13,
    "blue": 14,
]

struct d2 {
    func parseGameLine(_ line: String) throws -> [String: Any] {
        let gameNumber = line.components(separatedBy: ":")[0].components(separatedBy: " ")[1]
        let rounds = line.components(separatedBy: ":")[1].components(separatedBy: ";").map { round -> [String: Int] in
            let colors = round.components(separatedBy: ",")

            var roundColors: [String: Int] = [:]
            for color in colors {
                let colorComponents = color.components(separatedBy: " ")
                let colorName = colorComponents[2]
                let colorCount = Int(colorComponents[1].replacingOccurrences(of: " ", with: "")) ?? 0
                roundColors[colorName] = colorCount
            }
            return roundColors
        }

        return [
            "game": Int(gameNumber)!,
            "rounds": rounds,
        ]
    }

    func verifyRoundFeasibility(_ round: [String: Int]) -> Bool {
        let red = round["red"] ?? 0
        let green = round["green"] ?? 0
        let blue = round["blue"] ?? 0

        let redFeasible = red <= config["red"]!
        let greenFeasible = green <= config["green"]!
        let blueFeasible = blue <= config["blue"]!

        return redFeasible && greenFeasible && blueFeasible
    }

    func part1() throws -> Int {
        let file = URL(fileURLWithPath: "./d2/data.txt")
        do {
            let data: Data = try Data(contentsOf: file)
            if let content = String(data: data, encoding: .utf8) {
                let lines = content.components(separatedBy: "\n")
                do {
                    return try lines
                        .map { try parseGameLine($0) }
                        .map { game -> Int in
                            let rounds = game["rounds"] as! [[String: Int]]
                            let feasibleRounds = rounds.filter { verifyRoundFeasibility($0) }
                            if feasibleRounds.count == rounds.count {
                                return game["game"] as! Int
                            }
                            return 0
                        }
                        .reduce(0, +)
                } catch {
                    print("Error: \(error)")
                }
                return 0
            }
            return 0
        } catch {
            throw error
        }
    }

    func part2() throws -> Int {
        let file = URL(fileURLWithPath: "./d2/data.txt")
        do {
            let data: Data = try Data(contentsOf: file)
            if let content = String(data: data, encoding: .utf8) {
                let lines = content.components(separatedBy: "\n")
                do {
                    return try lines
                        .map { try parseGameLine($0) }
                        .map { game -> Int in
                            let rounds = game["rounds"] as! [[String: Int]]
                            let largestRed = rounds.map { $0["red"] ?? 0 }.max() ?? 0
                            let largestGreen = rounds.map { $0["green"] ?? 0 }.max() ?? 0
                            let largestBlue = rounds.map { $0["blue"] ?? 0 }.max() ?? 0
                            return largestRed * largestGreen * largestBlue
                        }
                        .reduce(0, +)
                } catch {
                    print("Error: \(error)")
                }
                return 0
            }
            return 0
        } catch {
            throw error
        }
    }
}

let day2 = d2()
try print(day2.part1())
try print(day2.part2())