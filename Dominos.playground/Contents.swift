//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport

struct Domino {
    var left: Int
    var right: Int
}

extension Domino: Equatable {
    static func ==(lhs: Domino, rhs: Domino) -> Bool {
        return lhs.left == rhs.left && lhs.right == rhs.right
    }
}

//var dominos = Set<(Domino)>()
var dominos = [Domino]()

(1...6).forEach { (leftside) in
    (1...6).forEach({ (rightside) in
        let domino = Domino(left: leftside, right: rightside)
        let dominoReversed = Domino(left: rightside, right: leftside)
//        print(domino)
        if !dominos.contains(domino) && !dominos.contains(dominoReversed) {
            dominos.append(domino)
        }
    })
}

print(dominos)

/// 147
let total = dominos.reduce(0) { (runningTotal, nextDomino) -> Int in
    return runningTotal + nextDomino.left + nextDomino.right
}

func drawDominoSide(number: Int, size: CGFloat, dotSize: CGFloat) -> UIView {
    let view = UIView(frame: CGRect(x: 0, y: 0, width: size, height: size))
    view.backgroundColor = .white
    view.layer.cornerRadius = 3
    
    let dot = UIView(frame: CGRect(x: 0, y: 0, width: dotSize, height: dotSize))
    dot.backgroundColor = .black
    dot.layer.cornerRadius = dotSize / 2
    
    if [1,3,5].contains(number) {
        dot.frame.offsetBy(dx: size/2 - dotSize/2, dy: size/2 - dotSize/2)
        view.addSubview(dot)
    }
    
    return view
}

//let domino1 = drawDominoSide(number: 1, size: 100, dotSize: 10)

//PlaygroundPage.current.liveView = domino1
