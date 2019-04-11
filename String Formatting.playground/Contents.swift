//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

func camelToTitle(_ from: String) -> String {
    var stringToReturn = ""
    
    let uppercase = CharacterSet.uppercaseLetters
    let lowercase = CharacterSet.lowercaseLetters
    
    for (index, character) in from.characters.map({String($0)}).enumerated() {
        guard let unicode = UnicodeScalar.init(character) else { continue }
        if lowercase.contains(unicode) {
            if index == 0 {
                stringToReturn += character.uppercased()
            } else {
                stringToReturn += character
            }
        } else if uppercase.contains(unicode) {
            stringToReturn += " \(character.uppercased())"
        }
    }
    
    return stringToReturn
}

/*
print(camelToTitle("thisIsATest"))
camelToTitle("")
camelToTitle("alllowercase")
camelToTitle("ALLUPPERCASE")
camelToTitle("camelToTitle")
*/

func sleepTrainerTimes() -> (maxCount: Int, bestMin: Int, bestMax: Int) {
    var maxCount = 0
    var bestMin = 0
    var bestMax = 0
    
    for min in 1...12 {
        let minSec = min * 5
        for max in 1...30 {
            let maxSec = max * 60
            let count = maxSec / minSec
            if count > maxCount {
                maxCount = count
                bestMin = minSec
                bestMax = maxSec
            }
        }
    }
    return (maxCount, bestMin, bestMax)
}

//sleepTrainerTimes()

import PlaygroundSupport

let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))

let exampleColour = UIColor(colorLiteralRed: 0.5, green: 0.25, blue: 0.1, alpha: 1)

class ExampleView: UIView {
    var exampleBackground: UIColor?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = exampleBackground ?? .red
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

let example = ExampleView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
example.exampleBackground = exampleColour

PlaygroundPage.current.liveView = example
