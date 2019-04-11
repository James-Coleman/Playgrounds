//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

import CoreLocation

let coord1 = CLLocation(latitude: 5.0, longitude: 3.0)
let coord2 = CLLocation(latitude: 5.0, longitude: 5.0)

let distance = coord1.distance(from: coord2) // (metres)

let lengthFormatter = LengthFormatter()
lengthFormatter.string(fromValue: distance, unit: .mile)

import MapKit

let distanceFormatter = MKDistanceFormatter()
distanceFormatter.locale = Locale(identifier: "en-US")
distanceFormatter.string(fromDistance: distance)

distanceFormatter.locale = Locale(identifier: "en-GB")
distanceFormatter.string(fromDistance: distance)

distanceFormatter.unitStyle = .full
distanceFormatter.string(fromDistance: distance)

distanceFormatter.unitStyle = .abbreviated
distanceFormatter.locale = Locale(identifier: "en-US")
distanceFormatter.string(fromDistance: distance)