import Foundation

struct d4 {
  func part1Solver(_ lines: [String]) throws -> Int {
    let sums = lines.map {
      let allNumbers = $0.components(separatedBy: ": ")[1]
      let winningNumbers = allNumbers.components(separatedBy: " | ")[0]
      let myNumbers = allNumbers.components(separatedBy: " | ")[1]
      let winningNumbersArray = winningNumbers.components(separatedBy: " ").map { Int($0) ?? 0 }.filter { $0 != 0 }
      let myNumbersArray = myNumbers.components(separatedBy: " ").map { Int($0) ?? 0 }.filter { $0 != 0 }
      var count = 0
      for number in myNumbersArray {
        if winningNumbersArray.contains(number) {
          if count == 0 {
            count = 1
          } else {
            count *= 2
          }
        }
      }
      return count
    }
    let totalSum = sums.reduce(0, +)
    return totalSum
  }

  func part1() throws {
    let file = URL(fileURLWithPath: "./d4/data.txt")
    do {
      let data: Data = try Data(contentsOf: file)
      if let content = String(data: data, encoding: .utf8) {
        let lines = content.components(separatedBy: "\n")
        let result = try part1Solver(lines)
        print(result)
      }
    } catch {
      throw error
    }
  }

  struct Card {
    let cardNumber: Int
    let winningNumbers: [Int]
    let myNumbers: [Int]
    var count: Int
  }

  func getWinningNumberCount(_ card: Card) -> Int {
    var count = 0
    for number in card.myNumbers {
      if card.winningNumbers.contains(number) {
        count += 1
      }
    }
    return count
  }

  func part2Solver(_ lines: [String]) throws -> Int {
    var cards = lines.map {
      let cardNumber = $0.components(separatedBy: ": ")[0].components(separatedBy: " ")[1]
      let allNumbers = $0.components(separatedBy: ": ")[1]
      let winningNumbers = allNumbers.components(separatedBy: " | ")[0]
      let myNumbers = allNumbers.components(separatedBy: " | ")[1]
      let winningNumbersArray = winningNumbers.components(separatedBy: " ").map { Int($0) ?? 0 }.filter { $0 != 0 }
      let myNumbersArray = myNumbers.components(separatedBy: " ").map { Int($0) ?? 0 }.filter { $0 != 0 }
      return Card(cardNumber: Int(cardNumber) ?? 0, winningNumbers: winningNumbersArray, myNumbers: myNumbersArray, count: 1)
    }

    for index in cards.indices {
      let currentCard = cards[index]
      let winningNumbers = getWinningNumberCount(currentCard)
      if winningNumbers > 0 {
        // print("card \(currentCard.cardNumber) has \(winningNumbers) winning numbers")
        for i in index + 1 ... index + winningNumbers {
          cards[i].count += currentCard.count
          // print("adding \(currentCard.count) to card \(cards[i].cardNumber)")
        }
      }
    }
    let totalSum = cards.reduce(0) { $0 + $1.count }
    return totalSum
  }

  func part2() throws {
    let file = URL(fileURLWithPath: "./d4/data.txt")
    do {
      let data: Data = try Data(contentsOf: file)
      if let content = String(data: data, encoding: .utf8) {
        let lines = content.components(separatedBy: "\n")
        let _ = try part2Solver(lines)
      }
    } catch {
      throw error
    }
  }
}

let day4 = d4()
try day4.part2()
