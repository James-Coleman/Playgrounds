//: Playground - noun: a place where people can play

import UIKit

let numFor = NumberFormatter()
numFor.minimumIntegerDigits = 1
numFor.minimumFractionDigits = 1
numFor.maximumFractionDigits = 3

func mengerCarpetArea(iteration: Int) -> Double {
    return iteration == 0 ? 1.0 : mengerCarpetArea(iteration: iteration - 1) * (8 / 9)
}

print(
    (0...20)
//    .map { numFor.string(from: NSNumber(value: mengerCarpetArea(iteration: $0))) }
        .map { mengerCarpetArea(iteration: $0) }
        .map { NSNumber(value: $0) }
        .map { numFor.string(from: $0) }
        .flatMap { $0 }
)

func memoisedMengerCarpetArea(upto: Int) -> [Double] {
    var areas: [Double] = [1.0]
    
    while areas.count - 1 < upto {
        areas.append(areas.last! * ( 8 / 9 ))
    }
    
    return areas
}

print(
    memoisedMengerCarpetArea(upto: 20)
        .flatMap { numFor.string(from: NSNumber(value: $0)) }
)

func memoRecursiveMengerCarpetAreas(upto: Int, existingValues: [Double] = [1.0]) -> [Double] {
    if existingValues.count - 1 == upto { // We already have all the values we need
        return existingValues
    } else {
        let nextValue = existingValues.last! * ( 8 / 9)
        let nextExistingValues = existingValues + [nextValue]
        return memoRecursiveMengerCarpetAreas(upto: upto, existingValues: nextExistingValues)
    }
}

print(
    memoRecursiveMengerCarpetAreas(upto: 20)
        .flatMap { numFor.string(from: NSNumber(value: $0)) }
)

var globalMemoisedMengerCarpetAreas: [Int: Double] = [0: 1.0]

func globalMemoisedMengerCarpetArea(iteration: Int) -> Double {
    if let area = globalMemoisedMengerCarpetAreas[iteration] {
        return area
    } else {
        let area = globalMemoisedMengerCarpetArea(iteration: iteration - 1) * ( 8 / 9 )
        globalMemoisedMengerCarpetAreas[iteration] = area
        return area
    }
}

print(
    (0...20)
        .map ( globalMemoisedMengerCarpetArea )
        .map { NSNumber(value: $0) }
        .map ( numFor.string )
        .flatMap { $0 }
)

//: [Cube Surface Area](@next)


