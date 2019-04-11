//: Playground - noun: a place where people can play

import UIKit

let max8DigitBinary = "11111111" // Max value of 8-bit binary string is 255 ((2^8) - 1)

let maxValue = pow(2, Double(max8DigitBinary.count)) - 1

let binaryInt = Int(max8DigitBinary, radix: 2) // This is an optional Int.

let dummyString = String(repeating: "0", count: 160)

//String(dummyString[120..<121])
