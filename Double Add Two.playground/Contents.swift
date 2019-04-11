//: Playground - noun: a place where people can play

import UIKit

func doubleAddTwo(upto: Int) -> [Int] {
    var array: [Int] = [1]
    
    for i in 2...upto {
        
        let lastNumber = array[i - 2]
        
        if i % 2 == 0 {
            array += [lastNumber * 2]
        } else {
            array += [lastNumber + 2]
        }
    }
    
    return array
}

let intArray = doubleAddTwo(upto: 14)

//print(intArray)
//print(intArray.reduce(0, +))

func doubleDoubleAddTwo(upto: Int) -> [Double] {
    var array: [Double] = [1]
    
    for i in 2...upto {
        
        let lastNumber = array[i - 2]
        
        if i % 2 == 0 {
            array += [lastNumber * 2]
        } else {
            array += [lastNumber + 2]
        }
    }
    
    return array
}

//let doubleArray = doubleDoubleAddTwo(upto: 150)
//
//print(doubleArray)
//print(doubleArray.reduce(0, +))

//func doubleAddTwoSingleLine(upto: Int) -> [Double] {
//    return [2...upto]
//    .enumerated()
//        .map { (index, int) in
//            return index % 2 == 0 ? double
//    }
//}

(1...14)
.enumerated()
    .forEach { print($0, $1); print($0 % 2 == 0 ? "Even" : "Odd") }
