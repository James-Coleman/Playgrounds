//: Playground - noun: a place where people can play

//import PlaygroundSupport
//
//PlaygroundPage.current.needsIndefiniteExecution = true

import UIKit
import PlaygroundSupport

//PlaygroundPage.current.needsIndefiniteExecution = true

var str = "Hello, playground"

func dispatchDemo() {
    let queue = DispatchQueue(label: "test")
    for i in (1...10) {
        print(i, "main")
        queue.async {
            print(i, "1st q 1")
            print(i, "1st q 2")
        }
        queue.async {
            print(i, "2nd q")
        }
    }
}

//dispatchDemo()

func operationDemo() {
    let queue = OperationQueue()
    
    for i in (1...10) {
        print(i, "main")
        queue.addOperation {
            print(i, "1st q 1")
            print(i, "1st q 2")
        }
        queue.addOperation {
            print(i, "2nd q")
        }
    }
}

//operationDemo()

func operationWait() {
    let queue = OperationQueue()
    
    queue.addOperation {
        for i in 0...9 {
            print("-", i)
        }
    }
    queue.addOperation {
        for i in 0...9 {
            print("--", i)
        }
    }
    for i in 0...9 {
        print("main 1", i)
    }
    queue.waitUntilAllOperationsAreFinished()
    for i in 0...9 {
        print("main 2", i)
    }
    queue.addOperation {
        for i in 0...9 {
            print("---", i)
        }
    }
}

//operationWait()

func operationCallback() {
    let queue = OperationQueue()
    
    let operation = BlockOperation { 
        for i in 0...9 {
            print(i)
        }
    }
    
    operation.completionBlock = {
        print("finished!")
    }
    
    print("main 1")
    
    queue.addOperation(operation)
    
    print("main 2")
}

//operationCallback()

func nestedOperation() {
    let queue = OperationQueue()
    
    let firstOperation = BlockOperation {
        var operationArray = [BlockOperation]()
        for i in 0...9 {
            let secondOperation = BlockOperation {
                print(i)
            }
            operationArray.append(secondOperation)
        }
        queue.addOperations(operationArray, waitUntilFinished: true)
        print("effectively a callback out of main thread")
    }
    
    print("main 1")
    
    queue.addOperation(firstOperation)
    
    print("main 2")
}

//nestedOperation()

func nestedOperation2() {
    let queue = OperationQueue()
    
    let firstOperation = BlockOperation {
        var operationArray = [BlockOperation]()
        for i in 0...99 {
            let secondOperation = BlockOperation {
                print(i)
            }
            operationArray.append(secondOperation)
        }
        queue.addOperations(operationArray, waitUntilFinished: true)
    }
    
    firstOperation.completionBlock = {
        print("official completion block")
    }
    
    print("main 1")
    
    queue.addOperation(firstOperation)
    
    print("main 2")
}

//nestedOperation2()

func manualOperation() {
    let queue = OperationQueue()
    
    let operation = BlockOperation {
        for i in 0...9 {
            print(i)
        }
    }
    
    while operation.isExecuting {
        print("1st operation is executing")
    }
    
    queue.addOperation(operation)
    
    while operation.isExecuting {
        print("2nd operation is executing")
    }
}

//manualOperation()

func twoOperationsDemo() {
    let userQueue = OperationQueue()
    userQueue.qualityOfService = .userInitiated
    
    let backgroundQueue = OperationQueue()
    backgroundQueue.qualityOfService = .background
    
    for i in (1...10) {
        userQueue.addOperation {
            print(i, "userInitiated")
        }
        backgroundQueue.addOperation {
            print(i, "background")
        }
    }
}

//twoOperationsDemo()

func singleBlockOperation() {
    let queue = OperationQueue()
    let blockOperation = BlockOperation()
    for i in 1...10 {
        blockOperation.addExecutionBlock {
            print(i)
//            print(blockOperation.isFinished)
        }
    }
    
    queue.addOperation(blockOperation)
}

//singleBlockOperation()

func multipleBlockOperations() {
    let queue = OperationQueue()
    for i in 1...10 {
        let blockOperation = BlockOperation(block: { 
            print(i)
        })
        queue.addOperation(blockOperation)
    }
}

//multipleBlockOperations()

func numberFormatterDemo() {
    let formatter = NumberFormatter()
    formatter.minimumIntegerDigits = 4
    for i in 1...10 {
        let number = NSNumber(value: i)
        guard let formattedNumber = formatter.string(from: number) else { return }
        print(formattedNumber)
    }
}

//numberFormatterDemo()

//print(UUID().uuidString)

//class LazyTest {
//    lazy var test = 5
//}
//
//let lazyTest = LazyTest()
//
//lazyTest.test

func myTestFunction(withAnInt int: Int) {
    print(int)
}

//myTestFunction(withAnInt: 5)

func myTestFunction(withAString  string: String) {
    print(string)
}

//myTestFunction(withAString: "hello")

func localisedMassFormatterDemo(value: Double, unit: MassFormatter.Unit) -> String {
    let mf = MassFormatter()
    print(Locale.current)
    return mf.string(fromValue: value, unit: unit)
}

//localisedMassFormatterDemo(value: 10, unit: .stone)
//localisedMassFormatterDemo(value: 10, unit: .kilogram)


