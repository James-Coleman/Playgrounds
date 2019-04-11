//: Playground - noun: a place where people can play

import UIKit
import XCPlayground

XCPlaygroundPage.currentPage.needsIndefiniteExecution = true

let date = Date()

print("date: ", date)

let futureTime = DispatchTime.now() + .seconds(2)
DispatchQueue.main.asyncAfter(deadline: futureTime) { 
    print("queuedDate: ", date)
}

func delay(_ delay:Double, closure:@escaping ()->()) {
    let when = DispatchTime.now() + delay
    DispatchQueue.main.asyncAfter(deadline: when, execute: closure)
}

delay(4) {
    print("delayedDate: ", date)
}

var currentTime: Date {
    return Date()
}

print("currentTime: ", currentTime)

delay(2) { 
    print("delayedCurrentTime: ", currentTime)
}