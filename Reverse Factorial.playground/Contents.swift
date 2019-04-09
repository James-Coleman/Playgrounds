//: Playground - noun: a place where people can play

import UIKit

func factorial(n: Int) -> Int? {
    guard n >= 0 else { return nil }
    
//    if n == 0 {
//        return 1
//    } else {
//        return factorial(n: n - 1)
//    }
    
    if n == 0 {
        return 1
    } else {
        guard let previousFactorial = factorial(n: n - 1) else { return nil }
        
        return n * previousFactorial
    }
}

factorial(n: 0)
factorial(n: 1)
factorial(n: 2)
factorial(n: 3)
factorial(n: 4)
factorial(n: 5)
factorial(n: 6)
factorial(n: 7)
factorial(n: 8)
factorial(n: 9)
factorial(n: 10)

func reverseFactorial(n: Int) -> Int? {
    guard n >= 1 else { return nil }
    
    for i in 0...n {
        guard let factorial = factorial(n: i) else { return nil }
//        guard factorial >= n else { return nil }
        if factorial > 2 {
            guard factorial <= n else { return nil }
        }
        
        if factorial == n {
            return i
        }
    }
    
    return nil
}

reverseFactorial(n: 1)
reverseFactorial(n: 2)
reverseFactorial(n: 6)
reverseFactorial(n: 24)
reverseFactorial(n: 120)
reverseFactorial(n: 720)
reverseFactorial(n: 5040)
reverseFactorial(n: 40320)
reverseFactorial(n: 362880)
reverseFactorial(n: 3628800)
