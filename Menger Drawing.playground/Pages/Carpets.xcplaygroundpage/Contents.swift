import UIKit
import PlaygroundSupport

extension UIView {
    /// https://stackoverflow.com/questions/27121655/create-a-copy-of-a-uiview-in-swift
    func copyView<T: UIView>() -> T {
        return NSKeyedUnarchiver.unarchiveObject(with: NSKeyedArchiver.archivedData(withRootObject: self)) as! T
    }
}

func mengerCarpetSquareCount(iteration: Int) -> Int {
    return Int(pow(8.0, Double(iteration)))
    
    /*
     
     if iteration == 0 { return 1 } // Handle iteration 0 'special case'
     
     var totalUnits = Int(pow(9.0, Double(iteration)))
     
     for _ in 1...iteration {
     let newTotalUnits = Double(totalUnits) * ( 8.0 / 9.0 )
     totalUnits = Int(newTotalUnits)
     }
     
     return totalUnits
     
     */
}

mengerCarpetSquareCount(iteration: 0)
mengerCarpetSquareCount(iteration: 4)

func mengerCarpet(iteration: Int, sideLength: Int = 600, margin: Int = 10) -> UIView {
    // Setup background view
    let view = UIView(frame: CGRect(x: 0, y: 0, width: sideLength, height: sideLength))
    view.backgroundColor = .white
    
    let carpetSideLength = sideLength - (margin * 2)
    let power = pow(3.0, Double(iteration))
    let unitSideLength = Double(carpetSideLength) / power
    
    let sideUnits = Int(power)
    
    for i in 1...sideUnits {
        let x = (Double(i - 1) * unitSideLength) + Double(margin)
        let newView = UIView(frame: CGRect(x: x, y: Double(margin), width: unitSideLength, height: unitSideLength))
        
        let hue = (1.0 / Double(sideUnits - 1)) * Double(i - 1)
        
        let colour = UIColor(hue: CGFloat(hue), saturation: 1, brightness: 1, alpha: 1)
        
        newView.backgroundColor = colour
        
        view.addSubview(newView)
    }
    
    return view
}

func singleMengerCarpet(sideLength: Double) -> UIView {
    let squareSize = sideLength / 3
    
    let view = UIView(frame: CGRect(x: 0, y: 0, width: sideLength, height: sideLength))
    view.backgroundColor = .white
    
    for x in 1...3 {
        for y in 1...3 {
            if x == 2 && y == 2 { continue } // Don't put a square in the centre
            let square = UIView(frame: CGRect(x: Double(x - 1) * squareSize , y: Double(y - 1) * squareSize, width: squareSize, height: squareSize))
            square.backgroundColor = .red
            
            view.addSubview(square)
        }
    }
    
    return view
}

func recursiveMengerCarpet(iteration: Int, sideLength: Double) -> UIView {
    let view = UIView(frame: CGRect(x: 0, y: 0, width: sideLength, height: sideLength))
    
    if iteration == 0 {
        view.backgroundColor = .red
        return view
    }
    
    view.backgroundColor = .white
    
    let sideLengthThird = sideLength / 3
    let sideLengthSixth = sideLength / 6
    
    let previousIteration = recursiveMengerCarpet(iteration: iteration - 1, sideLength: sideLengthThird)
    
    for x in 1...3 {
        for y in 1...3 {
            if x == 2 && y == 2 { continue } // Don't put a previous iteration in the centre
            
            previousIteration.center.x = CGFloat(Double(x - 1) * sideLengthThird + sideLengthSixth)
            previousIteration.center.y = CGFloat(Double(y - 1) * sideLengthThird + sideLengthSixth)
            
            // Make a copy of the previous iteration because it's a class and any further changes will be referenced
            let previousIterationCopy = previousIteration.copyView()
            
            // Add the copy to the view to return
            view.addSubview(previousIterationCopy)
        }
    }
    
    return view
}

func recursiveMengerCarpetCanvas(iteration: Int, sideLength: Double) -> UIView {
    let view = UIView(frame: CGRect(x: 0, y: 0, width: sideLength, height: sideLength))
    
    if iteration == 0 {
        view.backgroundColor = .red
        return view
    }
    
    view.backgroundColor = .white
    
    let sideLengthThird = sideLength / 3
    let sideLengthSixth = sideLength / 6
    
    let previousIteration = recursiveMengerCarpet(iteration: iteration - 1, sideLength: sideLengthThird)
    
    for x in 1...3 {
        for y in 1...3 {
            if x == 2 && y == 2 { continue } // Don't put a previous iteration in the centre
            
            previousIteration.center.x = CGFloat(Double(x - 1) * sideLengthThird + sideLengthSixth)
            previousIteration.center.y = CGFloat(Double(y - 1) * sideLengthThird + sideLengthSixth)
            
            // Make a copy of the previous iteration because it's a class and any further changes will be referenced
            let previousIterationCopy = previousIteration.copyView()
            
            // Add the copy to the view to return
            view.addSubview(previousIterationCopy)
        }
    }
    
    return view
}

class MengerCarpet1: UIView {
    var iteration: Int?
    
    init(frame: CGRect, iteration: Int) {
        self.iteration = iteration
        
        super.init(frame: frame)
        
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = .white
    }
    
    override func draw(_ rect: CGRect) {
        let oneThird = rect.width / 3
        
        var hue: CGFloat = 0
        
        for x in 0...2 {
            for y in 0...2 {
                if x == 1 && y == 1 { continue } // Skip the centre square
                
                let rect = CGRect(x: CGFloat(x) * oneThird, y: CGFloat(y) * oneThird, width: oneThird, height: oneThird)
                
//                if let iteration = iteration, iteration > 0 {
//                    let nextIteration = MengerCarpet(frame: rect, iteration: iteration - 1)
//
//                    addSubview(nextIteration)
//                } else {
                    let path = UIBezierPath(rect: rect)
                    
                    let colour = UIColor(hue: hue, saturation: 1, brightness: 1, alpha: 1)
                    
                    colour.setFill()
                    path.fill()
                    
                    hue += 0.125
//                }
            }
        }
    }
}

class MengerCarpet2: UIView {
    var iteration: Int
    
    init(frame: CGRect, iteration: Int) {
        self.iteration = iteration
        
        super.init(frame: frame)
        
        commonInit()
    }
    
    override init(frame: CGRect) {
        self.iteration = 0
        
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.iteration = 0
        
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = .white
    }
    
    override func draw(_ rect: CGRect) {
        let power = CGFloat(truncating: pow(3, iteration) as NSNumber)
        
        let squareSize = rect.width / power
        
        for specificIteration in 0...iteration {
            for x in 0...2 {
                for y in 0...2 {
                    if x == 1 && y == 1 { continue } // Skip centre
                    
                    let offset = (squareSize * 3) * CGFloat(specificIteration)
                    
                    let xPosition = (CGFloat(x) * squareSize) + offset
                    let yPosition = CGFloat(y) * squareSize  + offset
                    
                    let path = UIBezierPath(rect: CGRect(x: xPosition, y: yPosition, width: squareSize, height: squareSize))
                    
                    UIColor.red.setFill()
                    
                    path.fill()
                }
            }
        }
    }
}

func drawSingleMengerCarpet() -> UIView {
    let view = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
    
    let red = UIColor.red
    
    let upperLeft = UIBezierPath(rect: CGRect(x: 0, y: 0, width: 100, height: 100))
    
    red.setFill()
    
    upperLeft.fill()
    
    //    view.addSubview(upperLeft)
    
    return view
}

//PlaygroundPage.current.liveView = mengerCarpet(iteration: 1)
//PlaygroundPage.current.liveView = singleMengerCarpet(sideLength: 100)
//PlaygroundPage.current.liveView = recursiveMengerCarpet(iteration: 4, sideLength: 600)
PlaygroundPage.current.liveView = recursiveMengerCarpetCanvas(iteration: 3, sideLength: 600)
//PlaygroundPage.current.liveView = MengerCarpet1(frame: CGRect(x: 0, y: 0, width: 300, height: 300), iteration: 0)
//PlaygroundPage.current.liveView = MengerCarpet2(frame: CGRect(x: 0, y: 0, width: 300, height: 300), iteration: 2)











