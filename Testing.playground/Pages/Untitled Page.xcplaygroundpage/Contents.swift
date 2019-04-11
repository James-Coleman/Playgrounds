import UIKit
import XCTest

struct CustomSet {
    public var count: Int = 0
    private var items: [String?] = Array<String?>.init(repeating: nil, count: 10)
    
    mutating func add(_ item: String) {
        count += 1
        items += [item]
    }
    
    mutating func remove(_ item: String) {
        count -= 1
        for (index, existingItem) in items.enumerated() {
            if existingItem == item {
                items[index] = nil
                return
            }
        }
    }
    
    func contains(_ item: String) -> Bool {
        for existingItem in items {
            if existingItem == item {
                return true
            }
        }
        return false
    }
}

class SingleItemSetTests: XCTestCase {
    var sut: CustomSet!
    
    override func setUp() {
        super.setUp()
        sut = CustomSet()
        sut.add("item")
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testAdd() {
        XCTAssertGreaterThan(sut.count, 0)
    }

    func testCount() {
        XCTAssertEqual(sut.count, 1)
    }
    
    func testRemoveCount() {
        sut.remove("item")
        XCTAssertEqual(sut.count, 0)
    }
    
    func testRemoveItem() {
        sut.remove("item")
        XCTAssertFalse(sut.contains("item"))
    }
    
    func testContains() {
        XCTAssertTrue(sut.contains("item"))
    }
    
    func testDoesNotContain() {
        XCTAssertFalse(sut.contains("cheese"))
    }
}

class MultiItemSetTests: XCTestCase {
    var sut: CustomSet!
    
    override func setUp() {
        super.setUp()
        sut = CustomSet()
        sut.add("1")
        sut.add("2")
        sut.add("3")
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testAddMultiple() {
        XCTAssertGreaterThan(sut.count, 0)
    }
    
    func testCount() {
        XCTAssertEqual(sut.count, 3)
    }
    
    func testRemove() {
        sut.remove("1")
        XCTAssertEqual(sut.count, 2)
    }
    
}

class TestObserver: NSObject, XCTestObservation {
    func testCase(_ testCase: XCTestCase,
                  didFailWithDescription description: String,
                  inFile filePath: String?,
                  atLine lineNumber: Int) {
        assertionFailure(description, line: UInt(lineNumber))
    }
}

let testObserver = TestObserver()
XCTestObservationCenter.shared.addTestObserver(testObserver)
SingleItemSetTests.defaultTestSuite.run()
MultiItemSetTests.defaultTestSuite.run()
