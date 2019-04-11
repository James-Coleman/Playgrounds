//: Playground - noun: a place where people can play

import UIKit

let seedArray = [Int](1...10)

var seedArrayCount: Int {
    return seedArray.count
}

let nextArray = seedArray.enumerated().map { (offset: Int, element: Int) -> Int in
//    print(offset, element)
    let offsetPlusOne = offset + 1
    let offsetMod = offsetPlusOne % seedArrayCount
    return seedArray[offsetMod]
}

nextArray

let previousArray = seedArray.enumerated().map { (offset: Int, element: Int) -> Int in
    var offsetMinusOne = offset - 1
    while offsetMinusOne < 0 {
        offsetMinusOne += seedArrayCount
    }
    let offsetMod = offsetMinusOne % seedArrayCount
    return seedArray[offsetMod]
}

previousArray

let seedDictionary: [String:String] = ["A":"a", "B":"b", "C":"c", "D":"d"]

let nextLetterDict: [String: String] = ["A":"B", "B":"C", "C":"D", "D":"A"]

let nextDictionaryArray = seedDictionary.map { (key: String, value: String) -> [String:String] in
    let nextLetter = nextLetterDict[key]!
    return [nextLetter:value]
}

nextDictionaryArray

let nextDictionary = nextDictionaryArray.reduce([:]) { (dictionarySoFar, nextKeyValuePair) -> [String:String] in
    guard let first = nextKeyValuePair.first else { return [:] }
//    print(first)
    
    var varDictionarySoFar = dictionarySoFar
    varDictionarySoFar[first.key] = first.value
    return varDictionarySoFar
}

nextDictionary

let prevLetterDict: [String: String] = ["A":"D", "B":"A", "C":"B", "D":"C"]

let prevDictionary = seedDictionary.map { (key: String, value: String) -> [String:String] in
    let prevLetter = prevLetterDict[key]!
    return [prevLetter: value]
}

prevDictionary

var varSeedDictionary: [String:String] = ["A":"a", "B":"b", "C":"c", "D":"d"]

let example = varSeedDictionary.map { (key: String, value: String) -> [String:String] in
    let nextLetter = nextLetterDict[key]!
    return [nextLetter:value]
}

example

varSeedDictionary

func advance(rotor: [String: String], by: Int) -> [String:String] {
    var varRotor = rotor
    
    for _ in 1...by {
//        print("\(varRotor) : varRotor start")
        
        let nextRotorArray = varRotor.map { (key: String, value: String) -> [String:String] in
            let nextLetter = nextLetterDict[key]!
            return [nextLetter:value]
        }
//        print(nextRotorArray)
        
        let nextRotor = nextRotorArray.reduce([:], { (dictionarySoFar, nextKeyValuePair) -> [String:String] in
            guard let first = nextKeyValuePair.first else { return [:] }
            var varDictionarySoFar = dictionarySoFar
            varDictionarySoFar[first.key] = first.value
            return varDictionarySoFar
        })
        
//        print("\(nextRotor) : nextRotor")
        
        varRotor = nextRotor
        
//        print("\(varRotor) : varRotor")
    }
    
    return varRotor
}

advance(rotor: seedDictionary, by: 1)
