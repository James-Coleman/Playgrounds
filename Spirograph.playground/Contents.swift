//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

struct SpirographGenerator : IteratorProtocol {
    
    var pointOffset, dTheta, dR, minorRadius, majorRadius : Double
    var theta = 0.0
    typealias Element = CGPoint
    
    init(majorRadius : Double, minorRadius : Double, pointOffset : Double, samples : Double) {
        self.pointOffset = pointOffset
        self.dTheta = .pi * (2.0) / samples
        self.majorRadius = majorRadius
        self.minorRadius = minorRadius
        self.dR = majorRadius - minorRadius
    }
    
    mutating func next() -> CGPoint? {
        let xT : Double = dR * cos(theta) + pointOffset * cos(dR * theta / minorRadius)
        let yT : Double = dR * sin(theta) + pointOffset * sin (dR * theta / minorRadius)
        theta = theta + dTheta
        return CGPoint(x: xT, y: yT)
    }
}

//  sample size
let n = 100

//  offset in the image
let majorRadius: Double = 100
let minorRadius: Double = 10

//  iterations
let iterations = 15

var spiro = SpirographGenerator(majorRadius: majorRadius, minorRadius: minorRadius, pointOffset: 13, samples: Double(n))

let dimension_2: CGFloat = 300

//  image size
let size = CGSize(width: dimension_2 * 2, height: dimension_2 * 2)

UIGraphicsBeginImageContext(size)

let ctx = UIGraphicsGetCurrentContext()

for i in 0...iterations * n {
    let p: CGPoint? = spiro.next()
//    NSLog(“%@”,NSStringFromCGPoint(p!))
    if i == 0 {
        ctx?.move(to: CGPoint(x: p!.x+dimension_2, y: p!.y+dimension_2))
    } else {
        ctx?.addLine(to: CGPoint(x: p!.x+dimension_2, y: p!.y+dimension_2))
    }
}

ctx!.strokePath()

let image = UIGraphicsGetImageFromCurrentImageContext()

UIGraphicsEndImageContext()

let imageView = UIImageView(image: image)
imageView.backgroundColor = .white

// Present the view controller in the Live View window
PlaygroundPage.current.liveView = imageView
