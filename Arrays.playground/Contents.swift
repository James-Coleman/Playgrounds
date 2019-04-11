//: Playground - noun: a place where people can play

import UIKit

var array = [1,2,3]

array[2]

//array[4] // fatal error: Index out of range

array[2] = 33

array[2]

//array[3] = 4 // fatal error: Index out of range

array += [4]

array.append(5)

var decimal = Decimal(integerLiteral: 5)

12 == 34

12 == 12

12 as AnyObject === 12 as AnyObject

let first12 = 12 as AnyObject

let second12 = first12

second12 === first12

array

let newArray = array += [6]

array

var betterArray = array + [7]

array
betterArray

betterArray = betterArray + [8]

betterArray

func sayHelloFunc() -> String {
    return "Hello from function"
}

sayHelloFunc()

var sayHelloVar: String {
    return "Hello from constant"
}

sayHelloVar

//lazy var sayHelloLazyVar: String { // 'lazy' may not be used on a computed property
//    return "Hello from lazy var"
//}

var incrementable = 0
var increment: Int {
    return incrementable + 1
}

incrementable = increment
incrementable = increment

incrementable



let constantClosureAdd: (Int, Int) -> (Int) = {
    return $0 + $1
}

constantClosureAdd(1,2)

let constantString: () -> (String) = {
    return "hello"
}

let greeting = constantString()

let anyDict : [String : Any] = [
    "name": "James Coleman",
    "age": 27,
    "GCSEs" : [
        "English":"A",
        "Maths":"A",
        "Science":"A"
    ]
]

anyDict["name"]
anyDict["age"]
anyDict["GCSEs"]

let medianArray = [Int](1...10)

func medianValue(of array: [Int]) -> Double {
    let arrayCount = array.count
    if arrayCount % 2 == 0 {
        let intMiddle = arrayCount / 2
        let latterDouble = Double(array[intMiddle])
        let formerDouble = Double(array[intMiddle - 1])
        return ( latterDouble + formerDouble ) / 2
    } else {
        return Double(array[arrayCount/2])
    }
}

medianValue(of: medianArray)

medianArray.reduce(0, { (result, int) -> Int in
    return result + int
})

medianArray.reduce(0) { (result, int) -> Int in
    return result + int
}

let sum = medianArray.reduce(0) { $0 + $1 }
sum

medianArray.reduce(0, +)

let double = medianArray.map() {$0 * 2}
double

let square = medianArray.map() {$0 * $0}
square

let lessThan5 = medianArray.filter() {$0 < 5}
lessThan5

let greaterThan6 = medianArray.filter() {$0 > 6}
greaterThan6

let between2And8 = medianArray.filter() {($0 >= 2) && ($0 <= 8)}
between2And8

let lessThan4OrGreaterThan7 = medianArray.filter() {($0 < 4) || ($0 > 7)}
lessThan4OrGreaterThan7

let lessThanSort = medianArray.sorted(by: {$0 < $1})
lessThanSort

let greaterThanSort = medianArray.sorted() {$0 > $1}
greaterThanSort

if greaterThanSort is [Int] {
    print("greaterThanSort is an array of ints ([Int])")
}
