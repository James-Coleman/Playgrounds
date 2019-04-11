import Foundation

extension Int {
    static var diceRoll: Int {
        return Int.random(in: 1...6)
    }
}

let leetDictionary = [
    "a": ["4", "@"],
    "b": ["ß"],
    "c": ["ç"],
    "e": ["3", "£", "€"],
    "g": ["9"],
    "i": ["1", "!", "|"],
    "l": ["1", "|"],
    "m": ["nn"],
    "o": ["0"],
    "s": ["5", "$"],
    "v": ["^"],
    "w": ["uu", "\\/\\/"],
    "x": ["*"]
]

extension String {
    func leet(randomCapitalisation: Bool = false) -> String {
        let newWordArray = self.map { character -> String in
            let stringCharacter = String(character)
            let lowerCaseLetter = stringCharacter.lowercased()
            
            if leetDictionary.keys.contains(lowerCaseLetter) {
                if Bool.random() { // 50/50 chance
                    let leetArray = leetDictionary[lowerCaseLetter]! // Safe to force unwrap because of earlier check
                    let randomCharacter = leetArray.randomElement() ?? stringCharacter
                    return randomCharacter
                } else {
                    return stringCharacter
                }
            } else {
                return stringCharacter
            }
        }
        
        if randomCapitalisation {
            let randomCapWordArray = newWordArray.map { character -> String in
                if Bool.random() {
                    if CharacterSet.lowercaseLetters.contains(character.unicodeScalars.first!) {
                        return character.uppercased()
                    } else {
                        return character.lowercased()
                    }
                } else {
                    return character
                }
            }
            
            let randomCapWord = randomCapWordArray.joined()
            
            return randomCapWord
        } else {
            let newWord = newWordArray.joined()
            
            return newWord
        }
    }
}

"The quick brown fox jumps over the lazy dog".leet()
"aa bb cc ee gg ii ll mm oo ss vv ww xx".leet()
"AA BB CC EE GG II LL MM OO SS VV WW XX".leet()

"The quick brown fox jumps over the lazy dog".leet(randomCapitalisation: true)
"aa bb cc ee gg ii ll mm oo ss vv ww xx".leet(randomCapitalisation: true)
"AA BB CC EE GG II LL MM OO SS VV WW XX".leet(randomCapitalisation: true)

"helicopter".leet(randomCapitalisation: true)

let averageBoolCount = 10

let averageBoolArray = [Int](1...averageBoolCount).map { _ -> Int in

    let boolArray = [Int](1...100).map { _ in Bool.random() }
    boolArray.count
    let trues = boolArray.filter { $0 == true }
    let trueCount = trues.count
    return trueCount
}

let averageBoolSum = averageBoolArray.reduce(0, +)
let averageBool = averageBoolSum / averageBoolCount

let diceArray = [Int](1...60).map { _ in Int.diceRoll }
diceArray.count
let ones = diceArray.filter { $0 == 1 }
ones.count


