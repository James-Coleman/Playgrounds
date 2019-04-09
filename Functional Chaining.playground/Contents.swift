import UIKit

var str = "Hello, playground"

class MyNumber {
    var number: Int
    
    init(number: Int) {
        self.number = number
    }
}

extension MyNumber: CustomStringConvertible {
    var description: String {
        return "MyNumber \(self.number)"
    }
}

MyNumber(number: 1)

extension MyNumber {
    func addOne() -> MyNumber {
        self.number += 1
        return self
    }
    
    func add(_ number: Int) -> MyNumber {
        self.number += number
        return self
    }
    
}

MyNumber(number: 1)
    .addOne()
    .addOne()

MyNumber(number: 1)
    .add(5)

extension Int {
    func add(_ number: Int) -> Int {
        return self + number
    }
    
    func subtract(_ number: Int) -> Int {
        return self - number
    }
    
    func multiply(_ number: Int) -> Int {
        return self * number
    }
}

1
    .add(2)
    .subtract(4)
    .multiply(3)
