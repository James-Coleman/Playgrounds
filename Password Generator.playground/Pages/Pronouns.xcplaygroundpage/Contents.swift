import Foundation

extension Collection {
    
    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    /// From [StackOverflow](https://stackoverflow.com/questions/25329186/safe-bounds-checked-array-lookup-in-swift-through-optional-bindings)
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

enum Style: CaseIterable {
    case camel, kebab, underscore
}

enum Capitalisation: CaseIterable {
    case lower, upper, title
}

extension String {
    func styledFor(_ style: Style, _ capitalisation: Capitalisation, withNumberInRange numberRange: ClosedRange<Int>? = nil, withSymbolFrom symbols: String? = nil) -> String {
        let split = self.split(separator: " ")
        
        var styled = split.enumerated().map({ (offset, element) -> String in
            switch (style, capitalisation) {
            case (.camel, .lower):
                if offset == 0 {
                    return String(element)
                } else {
                    return element.capitalized
                }
            case (.camel, .upper), (.camel, .title):
                return element.capitalized
            case (_, .lower):
                return String(element) // already lowercase
            case (_, .upper):
                return element.uppercased()
            case (_, .title):
                return element.capitalized
            }
        })
        
        if let numberRange = numberRange {
            let randomNumber = Int.random(in: numberRange)
            let randomPlace = Int.random(in: 0...styled.count)
            styled.insert(String(randomNumber), at: randomPlace)
        }
        
        if let symbols = symbols, let randomSymbol = symbols.randomElement() {
            let randomPlace = Int.random(in: 0...styled.count)
            styled.insert(String(randomSymbol), at: randomPlace)
        }
        
        let seperator: String = {
            switch style {
            case .camel:
                return ""
            case .kebab:
                return "-"
            case .underscore:
                return "_"
            }
        }()
        
        return styled.joined(separator: seperator)
    }
}

"The quick brown fox jumps over the lazy dog".styledFor(.underscore, .lower, withNumberInRange: 1...1, withSymbolFrom: "!@£$%^&*()")

enum InitError: Error {
    case mustHaveAtLeastOneElement
}

struct Name {
    let array: [String]
    
    init(_ array: String...) throws {
        guard array.count > 0 else { throw InitError.mustHaveAtLeastOneElement }
        self.array = array
    }
    
    init(_ array: [String]) throws {
        guard array.count > 0 else { throw InitError.mustHaveAtLeastOneElement }
        self.array = array
    }
    
    init(_ string: String) throws {
        let split = string.split(separator: ".")
        guard split.count > 0 else { throw InitError.mustHaveAtLeastOneElement }
        self.array = split.map { String($0) }
    }
}

let first = try Name("ja", "mes")
let middle = try Name("leo", "nard")
let last = try Name("cole", "man", "ator")
last.array[safe: 2]
last.array[safe: 3]

struct SuperName {
    let array: [Name]
    
    init(_ array: Name...) throws {
        guard array.count > 0 else { throw InitError.mustHaveAtLeastOneElement }
        self.array = array
    }
    
    init(_ array: [[String]]) throws {
        guard array.count > 0 else { throw InitError.mustHaveAtLeastOneElement }
        self.array = try array.map { try Name($0) }
    }
    
    init(_ array: [String]) throws {
        guard array.count > 0 else { throw InitError.mustHaveAtLeastOneElement }
        self.array = try array.map { try Name($0) }
    }
    
    var jumbled: String {
        let counts = array.map { (name) -> Int in
            return name.array.count
        }
        let sortedCounts = counts.sorted(by: >)
        let highestCount = sortedCounts[0] // This is guaranteed to exist if the object was instantiated in the first place.
        
        var combined = [String]()
        
        for i in 0..<highestCount {
            for name in array {
                let nextPart = name.array[safe: i] ?? "" // This is filtered out below
                combined += [nextPart]
            }
        }
        
        let filtered = combined.filter { $0.isEmpty == false } // Filters out empty strings
        
        return filtered.joined(separator: " ")
    }
    
    /*
    var simplePassword: String {
        guard
            let style = Style.allCases.randomElement(),
            let capitalisation = Capitalisation.allCases.randomElement()
            else { return "" }
        
        return jumbled.styledFor(style, capitalisation)
    }
    */
    
    func password(withNumberInRange numberRange: ClosedRange<Int>? = nil, withSymbolFrom symbols: String? = nil) -> String {
        guard
            let style = Style.allCases.randomElement(),
            let capitalisation = Capitalisation.allCases.randomElement()
            else { return "" }
        
        return jumbled.styledFor(style, capitalisation, withNumberInRange: numberRange, withSymbolFrom: symbols)
    }
}

let superName = try SuperName(first, middle, last)
superName.jumbled
superName.password()

//print(first)
//print(superName)

try SuperName([["tes", "co"], ["as", "da"]]).password()

try SuperName(["Lon.don", "Craw.ley"]).password()
try SuperName(["Pur.ley", "Thet.ford"]).password()

try SuperName(["Al.ice", "Cole.man"]).password()

try SuperName(["Al.ice", "Har.ry"]).password()

try SuperName(["Medi.cal", "Ser.vices"]).password()

try SuperName(["Den.is", "Jack.ie"]).password()

try SuperName(["Ro.ke", "Wood.cote"]).password()

try SuperName(["Ro.ke", "Riddles.down"]).password()

try SuperName(["Saf.fi", "Ches.ter"]).password()


