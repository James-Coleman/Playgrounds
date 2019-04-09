//: Playground - noun: a place where people can play

import UIKit

extension Int {
    var isPrime: Bool {
        guard self >= 0 else { return false }
        guard self >= 3 else { return true }
        
        for i in 2...self-1 {
            if self % i == 0 {
                //            print("i: \(i), n: \(n)")
                return false
            }
        }
        
        return true
    }
    
    var concatenatedWithNMinus1: Int {
        return Int("\(self)\(self-1)")!
    }
}

let seedArray = [Int](1...100)

//let primes = seedArray.filter() { $0.isPrime }

//primes

//let seedConcatenated = seedArray.map() { return $0.concatenatedWithNMinus1 }

//seedConcatenated

//let concatenatedIsPrime = seedConcatenated.filter() { $0.isPrime }

//concatenatedIsPrime

let oeisSequence = seedArray.filter() { $0.concatenatedWithNMinus1.isPrime }

oeisSequence
