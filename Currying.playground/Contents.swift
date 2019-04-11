//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

func mathematical(symbol: String) -> ((Int, Int) -> Int)? {
    switch symbol {
    case "+":
        return {
            $0 + $1
        }
    case "-":
        return {
            $0 - $1
        }
    case "*":
        return {
            $0 * $1
        }
    case "/":
        return {
            $0 / $1
        }
    default:
        return nil
    }
}

if let adder = mathematical(symbol: "+") {
    adder(2, 3)
}

if let multiplier = mathematical(symbol: "*") {
    multiplier(2,3)
}

mathematical(symbol: "-")?(2,3)
mathematical(symbol: "-")!(2,3)

(mathematical(symbol: "?") ?? { $0 * $1 })(3,4)
