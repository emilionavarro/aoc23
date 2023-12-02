import Foundation

struct d1 {
    func getCombinedNumberFromLine(_ line: String) -> Int {
        let characters = Array(line)
        let first = characters[characters.firstIndex(where: { $0.isNumber }) ?? 0]
        let last = characters[characters.lastIndex(where: { $0.isNumber }) ?? 0]
        // if firstIndex == lastIndex { fuck me, I thought repeats were bad
        //     return Int("\(first)") ?? 0
        // }
        return Int("\(first)\(last)") ?? 0
    }

    func part1() throws -> Int {
        let day1data = URL(fileURLWithPath: "./d1/data/day1.txt")
        do {
            let data: Data = try Data(contentsOf: day1data)
            if let content = String(data: data, encoding: .utf8) {
                let lines: [String] = content.components(separatedBy: "\n")
                let numbers: [Int] = lines.map {
                    getCombinedNumberFromLine($0)
                }
                return numbers.reduce(0, +)
            }
            return 0
        } catch {
            throw error
        }
    }

    func mutateNamedNumbers(_ line: String) -> String {
        // beightwoxtjkxzfcqj9four -_- don't replace entire word, needs one overlap letter at most.
        let numberMap: [String: String] = [
            "one": "o1e",
            "two": "t2o",
            "three": "t3e",
            "four": "f4r",
            "five": "f5e",
            "six": "s6x",
            "seven": "s7n",
            "eight": "e8t",
            "nine": "n9e",
        ]

        return numberMap.reduce(line) { acc, curr -> String in
            acc.replacingOccurrences(of: curr.key, with: curr.value)
        }
    }

    func part2() throws -> Int {
        let day1data = URL(fileURLWithPath: "./d1/data/day1-part2.txt")
        do {
            let data: Data = try Data(contentsOf: day1data)
            if let content = String(data: data, encoding: .utf8) {
                let lines: [String] = content.components(separatedBy: "\n").map { mutateNamedNumbers($0) }
                let numbers: [Int] = lines.map { getCombinedNumberFromLine($0) }
                return numbers.reduce(0, +)
            }
            return 0
        } catch {
            throw error
        }
    }
}

let day1 = d1()
try print("part 1: \(day1.part1())")
try print("part 2: \(day1.part2())")
