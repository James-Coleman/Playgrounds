//: Playground - noun: a place where people can play

import Foundation

func primes(upto: Int) -> [Int] {
    
    var intArray = [Int](2...upto)
    
    for parent in intArray {
        for (index, child) in intArray.enumerated() {
            if parent == child {
                continue
            }
            
            if parent > child {
                continue
            }
            
            let square = parent * parent
            if square > child {
                continue
            }
            
            if let lastInt = intArray.last {
                let square = parent * parent
                if square > child {
                    continue
                }
            }
            
            print("parent: \(parent), child: \(child), index: \(index), count: \(intArray.count)")
            
            if child % parent == 0 {
                if let realIndex = intArray.index(of: child) {
                    print("realIndex: \(realIndex)")
                    intArray.remove(at: realIndex)
                }
            }
        }
    }
    
    return intArray
}

primes(upto: 100)