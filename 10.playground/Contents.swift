import UIKit

var str = "Hello, playground"

let queue = OperationQueue()

//queue.qualityOfService = .utility

for i in 1...5 {
    queue.addOperation {
        print("operation \(i)")
    }
}

print("-")

let dispatchQueue = DispatchQueue(label: "dispatchQueue", qos: .utility)

for i in 1...5 {
    dispatchQueue.async {
        print("dispatch \(i)")
    }
}

import PlaygroundSupport

PlaygroundPage.current.liveView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))


