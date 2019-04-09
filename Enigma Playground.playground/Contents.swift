//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

enum Rotor {
    case left(Int)
    case centre(Int)
    case right(Int)
    
//    case test(1)
    
}

let example = Rotor.centre(1)

let example2 = Rotor.centre

enum Rotor2: Int {
    case
    left,
    centre,
    right
}

let example3 = Rotor2.left.rawValue

//let example4 = Rotor2.left = 2

struct EgState {
    enum RotorPosition {
        case
        left,
        centre,
        right
    }
    
//    struct Rotor: RotorPosition { // "Error: Cannot inherit from non-protocol type"
    struct Rotor {
        var left = 0
        var centre = 1
        var right = 2
    }
}

var example5 = EgState.Rotor().left
example5 = 1
