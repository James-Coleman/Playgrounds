//: A UIKit based Playground for presenting user interface

import UIKit
import PlaygroundSupport

//: Variables

/// The width and height of the master view
let targetSize: Double = 600

/// How many bars there are
let barCount: Double = 20

/// How long the iniitial shuffle animation should take
let shuffleAnimationTime: TimeInterval = 3

/// How long the individual shuffle animations should take
let sortAnimationTime: TimeInterval = 0.1

/// How wide the bars are compared to their container. Should be between 0 and 1
let barWidthRatio: Double = 0.5

assert(barWidthRatio > 0, "barWidthRatio must be greater than 0, otherwise the bar will be invisible")
assert(barWidthRatio <= 1, "barWidthRatio must be less than or equal to 1, otherwise the bar will be larger than the container")

//: View Setup

/// The white view used as the basis for everything else. This is the Live View
let masterView = UIView(frame: CGRect(x: 0, y: 0, width: targetSize, height: targetSize))
masterView.backgroundColor = .white

let containerY: Double = 0
let containerWidth = targetSize / barCount

let barWidth = containerWidth * barWidthRatio

let min: Double = 20
let max = targetSize - min
let availableHeight = max - min
let individualHeight = availableHeight / barCount

/// This is an array that will contain all of the container view leading constraints
var leadingConstaints: [NSLayoutConstraint] = []

for i in 0..<Int(barCount) {
    
    let doubleI = Double(i)
    
    let containerX = doubleI * containerWidth
    
    let containerView = UIView(frame: CGRect(x: containerX, y: containerY, width: containerWidth, height: targetSize))
    containerView.translatesAutoresizingMaskIntoConstraints = false
    //    containerView.backgroundColor = .blue
    
    let height = individualHeight * (doubleI + 1)
    
    let colour = UIColor(hue: CGFloat(height / targetSize), saturation: 1, brightness: 1, alpha: 1)
    
    let bar = UIView(frame: CGRect(x: (containerWidth / 2) - (barWidth / 2), y: targetSize - height, width: barWidth, height: height))
    bar.backgroundColor = colour
    
    containerView.addSubview(bar)
    
    masterView.addSubview(containerView)
    
    NSLayoutConstraint.activate([containerView.bottomAnchor.constraint(equalTo: masterView.bottomAnchor),
                                 containerView.widthAnchor.constraint(equalToConstant: CGFloat(containerWidth)),
                                 containerView.heightAnchor.constraint(equalToConstant: CGFloat(targetSize))])
    
    let leadingConstraint = NSLayoutConstraint(item: containerView, attribute: .leading, relatedBy: .equal, toItem: masterView, attribute: .leading, multiplier: 1, constant: CGFloat(containerX))
    NSLayoutConstraint.activate([leadingConstraint])
    
    leadingConstaints += [leadingConstraint]
    
}

PlaygroundPage.current.liveView = masterView

//print(PlaygroundPage.current.liveView.debugDescription) // This was used to show that the masterView frame was reporting itself as the correct size, when not all of it was visible in the Live View.

let correctOrder = leadingConstaints

// Shuffle the leading constraints
leadingConstaints.shuffle()

// Assign the constants of the leading constraints to the shuffled indexed, making the bars appear shuffled.
for (index, constraint) in leadingConstaints.enumerated() {
    let doubleI = Double(index)
    
    let containerX = doubleI * containerWidth
    
    constraint.constant = CGFloat(containerX)
}

//: Sorting algorithms

func notQuiteBubbleSortButStillWorks() {
    //    while leadingConstaints != correctOrder {
    for (index, constraint) in leadingConstaints.enumerated() {
        if index == leadingConstaints.count - 1 { continue }
        let currentContainer = constraint.firstItem as! UIView
        let currentBar = currentContainer.subviews[0]
        let nextConstraint = leadingConstaints[index + 1]
        let nextContainer = nextConstraint.firstItem as! UIView
        let nextBar = nextContainer.subviews[0]
        if currentBar.frame.height > nextBar.frame.height {
            print(index)
            (constraint.constant, nextConstraint.constant) = (nextConstraint.constant, constraint.constant)
            (leadingConstaints[index], leadingConstaints[index + 1]) = (leadingConstaints[index + 1], leadingConstaints[index])
            
            UIView.animate(withDuration: sortAnimationTime, animations: {
                masterView.layoutIfNeeded()
            }) { (finished) in
                notQuiteBubbleSortButStillWorks()
            }
            
            return
        }
    }
    //    }
}

/*
 func bubbleSort() {
 var i: Int = 0
 
 /// How many times the algorithm has successfully passed over the array.
 /// Use this to not unnecesserily compare bars which should be already sorted.
 var completedPasses: Int = 0
 
 while i < leadingConstaints.count - 2 { // - 2 because we don't want to compare the last bar
 
 }
 }
 */

func singlePassBubbleSort(i: Int = 0) {
    var i = i
    
    while i < leadingConstaints.count - 1 {
        let constraint     = leadingConstaints[i]
        let nextConstraint = leadingConstaints[i + 1]
        
        let container     = constraint.firstItem as! UIView
        let nextContainer = nextConstraint.firstItem as! UIView
        
        let bar           = container.subviews[0]
        let nextBar       = nextContainer.subviews[0]
        
        if bar.frame.height > nextBar.frame.height {
            (constraint.constant, nextConstraint.constant) = (nextConstraint.constant, constraint.constant)
            (leadingConstaints[i], leadingConstaints[i + 1]) = (leadingConstaints[i + 1], leadingConstaints[i])
            
            UIView.animate(withDuration: sortAnimationTime, animations: {
                masterView.layoutIfNeeded()
            }) { (finished) in
                singlePassBubbleSort(i: i + 1)
            }
            
            return
        }
        
        i += 1
    }
}

func multiPassBubbleSort(index: Int = 0, pass: Int = 0) {
    var index = index
    
    let maxIndex = leadingConstaints.count - 1 - pass
    
    while index < maxIndex {
        let constraint     = leadingConstaints[index]
        let nextConstraint = leadingConstaints[index + 1]
        
        let container     = constraint.firstItem as! UIView
        let nextContainer = nextConstraint.firstItem as! UIView
        
        let bar           = container.subviews[0]
        let nextBar       = nextContainer.subviews[0]
        
        if bar.frame.height > nextBar.frame.height {
            (constraint.constant, nextConstraint.constant) = (nextConstraint.constant, constraint.constant)
            (leadingConstaints[index], leadingConstaints[index + 1]) = (leadingConstaints[index + 1], leadingConstaints[index])
            
            UIView.animate(withDuration: sortAnimationTime, animations: {
                masterView.layoutIfNeeded()
            }) { (finished) in
                if index == maxIndex - 1 {
                    multiPassBubbleSort(pass: pass + 1)
                } else {
                    multiPassBubbleSort(index: index + 1, pass: pass)
                }
            }
            
            return
        } else if index == maxIndex - 1 {
            multiPassBubbleSort(pass: pass + 1)
        }
        
        index += 1
    }
}

func reverseBubbleSort(index: Int = leadingConstaints.count - 2, pass: Int = 0) {
    var index = index
    
    while index >= pass {
        let constraint     = leadingConstaints[index]
        let nextConstraint = leadingConstaints[index + 1]
        
        let container     = constraint.firstItem as! UIView
        let nextContainer = nextConstraint.firstItem as! UIView
        
        let bar           = container.subviews[0]
        let nextBar       = nextContainer.subviews[0]
        
        if bar.frame.height > nextBar.frame.height {
            (constraint.constant, nextConstraint.constant) = (nextConstraint.constant, constraint.constant)
            (leadingConstaints[index], leadingConstaints[index + 1]) = (leadingConstaints[index + 1], leadingConstaints[index])
            
            UIView.animate(withDuration: sortAnimationTime, animations: {
                masterView.layoutIfNeeded()
            }) { (finished) in
                if index == pass {
                    reverseBubbleSort(pass: pass + 1)
                } else {
                    reverseBubbleSort(index: index - 1, pass: pass)
                }
            }
            
            return
        } else if index == pass {
            reverseBubbleSort(pass: pass + 1)
        }
        
        index -= 1
    }
}

func rippleSort(index: Int = 0, pass: Int = 0, ascending: Bool = true) {
    var index = index
    
    if ascending {
        
        let maxIndex = leadingConstaints.count - 1 - pass
        
        while index < maxIndex {
            let constraint     = leadingConstaints[index]
            let nextConstraint = leadingConstaints[index + 1]
            
            let container     = constraint.firstItem as! UIView
            let nextContainer = nextConstraint.firstItem as! UIView
            
            let bar           = container.subviews[0]
            let nextBar       = nextContainer.subviews[0]
            
            if bar.frame.height > nextBar.frame.height {
                (constraint.constant, nextConstraint.constant) = (nextConstraint.constant, constraint.constant)
                (leadingConstaints[index], leadingConstaints[index + 1]) = (leadingConstaints[index + 1], leadingConstaints[index])
                
                UIView.animate(withDuration: sortAnimationTime, animations: {
                    masterView.layoutIfNeeded()
                }) { (finished) in
                    if index == maxIndex - 1 {
                        rippleSort(index: index, pass: pass, ascending: ascending == false)
                    } else {
                        rippleSort(index: index + 1, pass: pass, ascending: ascending)
                    }
                }
                
                return
            } else if index == maxIndex - 1 {
                rippleSort(index: index, pass: pass, ascending: ascending == false)
                return // This return probably isn't necessary because we will fall out of the while loop anyway.
            }
            
            index += 1
        }
    } else {
        // Descending
        
//        let minIndex =
        
        while index >= pass {
            let constraint     = leadingConstaints[index]
            let nextConstraint = leadingConstaints[index + 1]
            
            let container     = constraint.firstItem as! UIView
            let nextContainer = nextConstraint.firstItem as! UIView
            
            let bar           = container.subviews[0]
            let nextBar       = nextContainer.subviews[0]
            
            if bar.frame.height > nextBar.frame.height {
                (constraint.constant, nextConstraint.constant) = (nextConstraint.constant, constraint.constant)
                (leadingConstaints[index], leadingConstaints[index + 1]) = (leadingConstaints[index + 1], leadingConstaints[index])
                
                UIView.animate(withDuration: sortAnimationTime, animations: {
                    masterView.layoutIfNeeded()
                }) { (finished) in
                    if index == pass {
                        rippleSort(index: index, pass: pass + 1, ascending: ascending == false)
                    } else {
                        rippleSort(index: index - 1, pass: pass, ascending: ascending)
                    }
                }
                
                return
            } else if index == pass {
                print("didn't sort anything, index & pass: \(pass)")
                rippleSort(index: index, pass: pass + 1, ascending: ascending == false)
                return // This return probably isn't necessary because we will fall out of the while loop anyway.
            }
            
            index -= 1
        }
    }
    
}

//: Animate the bars into position and start the sorting when the animation is complete

UIView.animate(withDuration: shuffleAnimationTime, animations: {
    masterView.layoutIfNeeded()
}) { (finished) in
    //    notQuiteBubbleSortButStillWorks()
//    multiPassBubbleSort()
//    reverseBubbleSort()
    rippleSort() // Working but not stopping. Endlessly recursing.
}






