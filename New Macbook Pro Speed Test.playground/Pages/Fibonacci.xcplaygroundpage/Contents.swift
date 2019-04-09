//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

func nthFibonacci(n: Int) -> Int? {
    var seedZero = 0
    var seedOne = 1
    
    switch n {
    case _ where n < 0:
        return nil
    case _ where n == 0:
        return seedZero
    case _ where n == 1:
        return seedOne
    default:
        for _ in 2...n {
            (seedZero, seedOne) = (seedOne, seedZero + seedOne)
        }
        return seedOne
    }
}

nthFibonacci(n: 0)
nthFibonacci(n: 1)
nthFibonacci(n: 2)
nthFibonacci(n: 3)
nthFibonacci(n: 4)
nthFibonacci(n: 5)
nthFibonacci(n: 6)
nthFibonacci(n: 7)
nthFibonacci(n: 8)
nthFibonacci(n: 9)
nthFibonacci(n: 10)
let intTestBefore = NSDate().timeIntervalSinceReferenceDate
nthFibonacci(n: 92)
let intTestAfter = NSDate().timeIntervalSinceReferenceDate
let intTestDuration = intTestAfter - intTestBefore
print("Int test took \(intTestDuration) seconds")
//nthFibonacci(n: 93) // Error

func nthFibonacciDouble(n: Int) -> Double? {
    var seedZero = 0.0
    var seedOne = 1.0
    
    switch n {
    case _ where n < 0:
        return nil
    case _ where n == 0:
        return seedZero
    case _ where n == 1:
        return seedOne
    default:
        for _ in 2...n {
            (seedZero, seedOne) = (seedOne, seedZero + seedOne)
        }
        return seedOne
    }
}

let doubleTestBefore = NSDate().timeIntervalSinceReferenceDate
nthFibonacciDouble(n: 92)
let doubleTestAfter = NSDate().timeIntervalSinceReferenceDate
let doubleTestDuration = doubleTestAfter - doubleTestBefore
print("Double test took \(doubleTestDuration) seconds")
nthFibonacciDouble(n: 93)
nthFibonacciDouble(n: 1476)
//nthFibonacciDouble(n: 1477) // inf
