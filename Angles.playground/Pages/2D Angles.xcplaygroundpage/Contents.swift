//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

extension CGFloat {
    var radToDeg: CGFloat {
        return (self / (2 * .pi)) * 360
    }
}

CGFloat.pi.radToDeg // Proves the above extension variable works

let mainView = UIView(frame: CGRect(x: 0, y: 0, width: 600, height: 600))
mainView.backgroundColor = .white

//let origin = CGPath(ellipseIn: CGRect(x: 0, y: 0, width: 50, height: 50), transform: nil)
let origin = UIView(frame: CGRect(x: -25, y: -25, width: 50, height: 50))
origin.backgroundColor = .red
origin.layer.cornerRadius = 25

mainView.addSubview(origin)

//let object = UIView(frame: CGRect(x: 275, y: 200, width: 200, height: 50))
let object = UIView(frame: CGRect(x: 300, y: 300, width: 50, height: 50))
object.backgroundColor = .black

let offset: CGFloat = .pi / 4
object.transform = CGAffineTransform(rotationAngle: offset)

mainView.addSubview(object)

//let camera = UIView(frame: CGRect(x: 400, y: 400, width: 10, height: 10))
let camera = UIView(frame: CGRect(x: 200, y: 400, width: 50, height: 50))
camera.backgroundColor = .blue

mainView.addSubview(camera)

// Present the view controller in the Live View window
PlaygroundPage.current.liveView = mainView

origin.center
object.center
camera.center

let dx = object.center.x - camera.center.x
let dy = object.center.y - camera.center.y

let radAngle = atan2(dx, dy) // A range from -pi to +pi
//let radAngle2 = atan2(dy, dx) // (dx, dy) or (dy, dx) doesn't matter, it only offsets by 90º

var adjustedRadAngle: CGFloat = { // Converts the radAngle to a clockwise range from 0...+2pi
    if radAngle <= 0 {
        return abs(radAngle)
    } else {
        return (2 * .pi) - radAngle
    }
}()

let degAngle = radAngle.radToDeg
//let degAngle2 = radAngle2.radToDeg

let degAdjusted = adjustedRadAngle.radToDeg

var offsetAdjustedAngle = radAngle - offset

let degOffsetAdjustedAngle = offsetAdjustedAngle.radToDeg

var adjustedOffsetRadAngle: CGFloat = { // Converts the radAngle to a clockwise range from 0...+2pi
    if offsetAdjustedAngle <= 0 {
        return abs(offsetAdjustedAngle)
    } else {
        return (2 * .pi) - offsetAdjustedAngle
    }
}()

let degAdjustedOffsetAngle = adjustedOffsetRadAngle.radToDeg
