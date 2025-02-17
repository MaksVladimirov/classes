import Foundation

// Родительский класс House
class House {
    var width: Double
    var height: Double
    
    init(width: Double, height: Double) {
        self.width = width
        self.height = height
    }
    
    func create() {
        print("Дом построен. Площадь: \(width * height) кв.м")
    }
    
    func destroy() {
        print("Дом уничтожен")
    }
}

// Дочерний класс Apartment
class Apartment: House {
    var floor: Int
    
    init(width: Double, height: Double, floor: Int) {
        self.floor = floor
        super.init(width: width, height: height)
    }
}

// Дочерний класс Cottage
class Cottage: House {
    var hasGarden: Bool
    
    init(width: Double, height: Double, hasGarden: Bool) {
        self.hasGarden = hasGarden
        super.init(width: width, height: height)
    }
}

// Класс для сортировки учеников
class StudentSorter {
    struct Student {
        let name: String
        let grade: Int
    }
    
    static func sortByName(students: [Student]) -> [Student] {
        return students.sorted { $0.name < $1.name }
    }
    
    static func sortByGrade(students: [Student]) -> [Student] {
        return students.sorted { $0.grade > $1.grade }
    }
}

// Структура и класс - различия
struct Point {
    var x: Int
    var y: Int
}

class Position {
    var x: Int
    var y: Int
    
    init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
}

/*
Различия:
- Структуры (struct) передаются по значению (value type), а классы (class) — по ссылке (reference type).
- Структуры автоматически имеют конструктор по умолчанию.
- Классы поддерживают наследование, структуры — нет.
*/

// Покерная игра
enum Suit: String, CaseIterable {
    case hearts = "червей"
    case diamonds = "бубей"
    case clubs = "треф"
    case spades = "пик"
}

enum Rank: String, CaseIterable {
    case two = "2", three = "3", four = "4", five = "5", six = "6", seven = "7", eight = "8", nine = "9", ten = "10"
    case jack = "Валет", queen = "Дама", king = "Король", ace = "Туз"
}

struct Card {
    let suit: Suit
    let rank: Rank
}

func generateHand() -> [Card] {
    let deck = Suit.allCases.flatMap { suit in
        Rank.allCases.map { rank in Card(suit: suit, rank: rank) }
    }
    return Array(deck.shuffled().prefix(5))
}

func checkCombination(hand: [Card]) -> String {
    let suits = Set(hand.map { $0.suit })
    let ranks = hand.map { $0.rank }
    
    let isFlush = suits.count == 1
    let sortedRanks = ranks.compactMap { Rank.allCases.firstIndex(of: $0) }.sorted()
    let isStraight = sortedRanks.enumerated().allSatisfy { index, value in
        index == 0 || value == sortedRanks[index - 1] + 1
    }
    
    if isFlush && isStraight {
        return "У вас стрит флеш \(hand[0].suit.rawValue)"
    } else if isFlush {
        return "У вас флеш \(hand[0].suit.rawValue)"
    } else if isStraight {
        return "У вас стрит"
    }
    return "У вас обычная комбинация"
}

// Генерация и проверка покерной руки
let hand = generateHand()
hand.forEach { print("\($0.rank.rawValue) \($0.suit.rawValue)") }
print(checkCombination(hand: hand))
