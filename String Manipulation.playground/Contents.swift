//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

let seeds = [Int](3...20)
let thousands = seeds.map() { $0 * 5000 }

let formatter = NumberFormatter()
formatter.currencyCode = "GBP"
formatter.usesGroupingSeparator = true
formatter.maximumFractionDigits = 0
formatter.numberStyle = .currency

let strings = thousands.map() {formatter.string(from: NSNumber(value: $0))}

func arrayUnwrapper<T>(array: [T?]) -> [T] {
    let notNil = array.filter() { $0 != nil }
    let unwrapped = notNil.map() { $0! }
    return unwrapped
}

let unwrappedStrings = arrayUnwrapper(array: strings)

let backToNumbers = unwrappedStrings.map() { formatter.number(from: $0) }

let unwrappedNumbers = arrayUnwrapper(array: backToNumbers)

