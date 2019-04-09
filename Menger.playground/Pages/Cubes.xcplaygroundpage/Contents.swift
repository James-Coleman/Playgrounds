//: [Previous](@previous)

import Foundation

/*
 From one iteration to the next there are 20 times as many cubes
*/
func mengerNumberOfCubes(iteration: Int) -> Decimal {
    return pow(20, iteration)
}

print((0...5).map(mengerNumberOfCubes))

//: [Next](@next)
