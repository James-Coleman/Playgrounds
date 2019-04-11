//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

class MyViewController : UIViewController {
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white

        let label = UILabel()
        label.frame = CGRect(x: 150, y: 200, width: 200, height: 20)
        label.text = "Hello World!"
        label.textColor = .black
        
        view.addSubview(label)
        self.view = view
    }
}

let vc = MyViewController()
vc.title = "After the Fact"
vc.view.subviews[0] as! UILabel
let navCon = UINavigationController(rootViewController: vc)

// Present the view controller in the Live View window
PlaygroundPage.current.liveView = navCon

import XCTest

class ExampleTests: XCTestCase {
    var testVC: MyViewController!
    var testNVC: UINavigationController!
    
    override func setUp() {
        super.setUp()
        
        let myVC = MyViewController()
        testVC = myVC
        testNVC = UINavigationController(rootViewController: myVC)
    }
    
    func testLabel() {
        XCTAssertTrue(testVC.view.subviews.count == 1, "There should be only one subview") // Changing this to a number other than "1" is the easiest way to make a test fail.
        XCTAssertTrue(testVC.view.subviews[0] is UILabel, "The view in the VC should be a Label")
    }
    
    func testNavTitle() {
        XCTAssertTrue(testVC.title == nil, "The VC title should not be set yet")
        let testTitle = "testTitle"
        testVC.title = testTitle
        XCTAssertTrue(testVC.title == testTitle, "The VC title should now be set")
    }
}

class Observer: NSObject, XCTestObservation {
    func testCase(_ testCase: XCTestCase,
                  didFailWithDescription description: String,
                  inFile filePath: String?,
                  atLine lineNumber: Int) {
        assertionFailure(description, line: UInt(lineNumber))
    }
}

let observer = Observer()

XCTestObservationCenter.shared.addTestObserver(observer) // This causes the Playground execution to Error when a test fails.

ExampleTests.defaultTestSuite.run()
