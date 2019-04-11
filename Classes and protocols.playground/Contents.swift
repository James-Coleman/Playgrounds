//: Playground - noun: a place where people can play

import UIKit

enum Manufacturer: String {
    case
    honda,
    nissan
}

class Vehicle {
    let make: Manufacturer
    let model: String
    
    var description: String {
        return "\(make.rawValue) \(model)"
    }
    
    init(make: Manufacturer, model: String) {
        self.make = make
        self.model = model
    }
}

//let jazz = Vehicle(make: .honda, model: "Jazz")

protocol FamilyVehicle {
    var storageSpace: Int { get }
}

class Car: Vehicle, FamilyVehicle {
    internal var storageSpace: Int

    let passengers: Int
    
    init(make: Manufacturer, model: String, passengers: Int, storage: Int) {
        self.storageSpace = storage
        self.passengers = passengers
        super.init(make: make, model: model)
    }
}

let jazz = Car(make: .honda, model: "Jazz", passengers: 4, storage: 5)
jazz.description

class MotorCycle: Vehicle {
    let sidecar: Bool
    
    init(make: Manufacturer, model: String, sidecar: Bool) {
        self.sidecar = sidecar
        super.init(make: make, model: model)
    }
}

