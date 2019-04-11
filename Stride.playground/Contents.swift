//: Playground - noun: a place where people can play

import UIKit

//: stride(from: to: by: ) does not include the last `to` value
for angle in stride(from: 0, to: 360, by: 15) {
    print(angle)
}

//: stride(from: through: by: ) includes the last `through` value
for height in stride(from: 0, through: 100, by: 10) {
    print(height)
}

//: stride can countdown
for countdown in stride(from: 5, through: 1, by: -1) {
    print(countdown)
    if countdown == 1 {
        print("Thunderbirds are go")
    }
}

//: Even with a large gap, it won't return a number out of range
for unevenNumber in stride(from: 0, through: 23, by: 13) {
    print(unevenNumber)
}

//: Sometimes stride will never execute
for impossibleNumber in stride(from: 10, to: 5, by: 1) {
    print(impossibleNumber) // Never printed because lower bound (from) is higher than upper bound (to), and the `by` parameter is ascending.
}

for onlyFirstNumber in stride(from: 0, to: 5, by: 10) {
    print(onlyFirstNumber)
}
