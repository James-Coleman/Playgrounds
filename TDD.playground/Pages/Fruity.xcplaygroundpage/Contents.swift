import UIKit

enum Fruit: String {
    case apple, orange
    
    var cost: Int {
        switch self {
        case .apple:
            return 10
        case .orange:
            return 12
        }
    }
}

struct FruitModel {
    var delegate: FruitModelDelegate!
    
    public private(set) var fruits: [Fruit] {
        didSet {
            fruits
            delegate.fruitModelDidUpdate(to: self)
        }
    }
    
    public mutating func addApple() {
        fruits += [.apple]
    }
    
    public mutating func addOrange() {
        fruits += [.orange]
    }
    
    public mutating func resetFruit() {
        fruits = []
    }
    
    init(delegate: FruitModelDelegate) {
        self.delegate = delegate
        self.fruits = []
    }
    
    init() {
        self.fruits = []
    }
}

protocol FruitModelDelegate {
    func fruitModelDidUpdate()
    func fruitModelDidUpdate(to newModel: FruitModel)
}

struct FruitViewModel {
    var delegate: FruitViewModelDelegate
    
    var model: FruitModel {
        didSet {
            model.fruits
            summaryLabelText
            delegate.fruitViewModelDidUpdate()
        }
    }
    
    var summaryLabelText: String {
        model.fruits
        let fruitStrings = model.fruits.map { $0.rawValue }
        let combined = fruitStrings.enumerated().reduce("") { (soFar, arg1) -> String in
            let (offset, element) = arg1
            
            if offset == 0 {
                return "\(element)"
            } else {
                return "\(soFar), \(element)"
            }
        }
        let capitalised = combined.capitalized
        return capitalised
    }
    
    func summaryLabelText(from model: FruitModel) -> String {
        let fruitStrings = model.fruits.map { $0.rawValue }
        let combined = fruitStrings.enumerated().reduce("") { (soFar, arg1) -> String in
            let (offset, element) = arg1
            
            if offset == 0 {
                return "\(element)"
            } else {
                return "\(soFar), \(element)"
            }
        }
        let capitalised = combined.capitalized
        return capitalised
    }
    
    var totalCostLabelText: String {
        model.fruits
        return "\(model.fruits.reduce(0) { $0 + $1.cost })"
    }
    
    func totalCostLabelText(from model: FruitModel) -> String {
        return "\(model.fruits.reduce(0) { $0 + $1.cost })"
    }
    
    public mutating func tappedAddApple() {
        model.addApple()
    }
    
    public mutating func tappedAddOrange() {
        model.addOrange()
    }
    
    public mutating func tappedReset() {
        model.resetFruit()
    }
    
    private mutating func setModel(to newModel: FruitModel) {
        self.model = newModel
    }
    
    init(delegate: FruitViewModelDelegate) {
        self.delegate = delegate
        self.model = FruitModel()
        self.model.delegate = self
    }
}

extension FruitViewModel: FruitModelDelegate {
    func fruitModelDidUpdate() {
        model.fruits
        delegate.fruitViewModelDidUpdate()
    }
    
    func fruitModelDidUpdate(to newModel: FruitModel) {
        newModel.fruits
//        delegate.fruitViewModelDidUpdate()
    }
}

protocol FruitViewModelDelegate {
    func fruitViewModelDidUpdate()
}

final class FruitView: UIViewController {
    var summaryLabel: UILabel!
    var totalLabel: UILabel!
    
    lazy var viewModel: FruitViewModel = {
        return FruitViewModel(delegate: self)
    }()
    
    @objc private func tappedAddApple() {
        viewModel.tappedAddApple()
    }
    
    @objc private func tappedAddOrange() {
        viewModel.tappedAddOrange()
    }
    
    @objc private func tappedReset() {
        viewModel.tappedReset()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupInitialView()
        updateView()
    }
    
    private func setupInitialView() {
        vc.title = "Fruit Summer"
        
        view.backgroundColor = .white
        
        let appleButton = UIButton(type: .system)
        appleButton.setTitle("Add Apple", for: .normal)
        appleButton.addTarget(self, action: #selector(tappedAddApple), for: .touchUpInside)
        
        let orangeButton = UIButton(type: .system)
        orangeButton.setTitle("Add Orange", for: .normal)
        orangeButton.addTarget(self, action: #selector(tappedAddOrange), for: .touchUpInside)
        
        let buttonStack = UIStackView(arrangedSubviews: [appleButton, orangeButton])
        buttonStack.translatesAutoresizingMaskIntoConstraints = false
        buttonStack.distribution = .fillEqually
        buttonStack.alignment = .top
        
        let summaryLabel = UILabel()
        summaryLabel.text = ""
        self.summaryLabel = summaryLabel
        
        let totalLabel = UILabel()
        totalLabel.text = ""
        self.totalLabel = totalLabel
        
        let resetButton = UIButton(type: .system)
        resetButton.setTitle("Reset", for: .normal)
        resetButton.addTarget(self, action: #selector(tappedReset), for: .touchUpInside)
        
        let rootStack = UIStackView(arrangedSubviews: [buttonStack, summaryLabel, totalLabel, resetButton])
        rootStack.translatesAutoresizingMaskIntoConstraints = false
        rootStack.alignment = .fill
        rootStack.axis = .vertical
        rootStack.distribution = .fill
        rootStack.spacing = 8
        
        view.addSubview(rootStack)
        
        NSLayoutConstraint.activate([
            rootStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            rootStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            rootStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
//            rootStack.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
    }
    
    private func updateView() {
        viewModel.summaryLabelText
        summaryLabel.text = viewModel.summaryLabelText
        totalLabel.text = viewModel.totalCostLabelText
    }
}

extension FruitView: FruitViewModelDelegate {
    func fruitViewModelDidUpdate() {
        updateView()
        viewModel.model.fruits
    }
}

// MARK: - Playground Live View

import PlaygroundSupport

let vc = FruitView()
let navCon = UINavigationController(rootViewController: vc)

PlaygroundPage.current.liveView = navCon

// MARK: - Tests

import XCTest

class FruitViewTests: XCTestCase {
    var vc: FruitView!
    
    var rootStackView: UIStackView {
        return vc.view.subviews[0] as! UIStackView
    }
    
    var buttonStackView: UIStackView {
        return rootStackView.subviews[0] as! UIStackView
    }
    
    var summaryLabel: UILabel {
        return rootStackView.subviews[1] as! UILabel
    }
    
    var totalLabel: UILabel {
        return rootStackView.subviews[2] as! UILabel
    }
    
    override func setUp() {
        super.setUp()
        
        vc = FruitView()
    }
    
    func testCanMakeVC() {
        XCTAssertNotNil(FruitView())
    }
    
    func testVCHasStackView() {
        XCTAssert(vc.view.subviews.count == 1, "Fruit Calculator should have a stackview in it's view")
        XCTAssert(vc.view.subviews[0] is UIStackView, "The first view of the VC should be a StackView")
    }
    
    func testViewIsWhite() {
        XCTAssert(vc.view.backgroundColor == .white, "VC background colour should be white")
    }
    
    func testStackViewContainsView() {
        XCTAssert(buttonStackView.arrangedSubviews.count > 0, "StackView should contain some subviews")
    }
    
    func testStackViewContainsButton() {
        XCTAssert(buttonStackView.arrangedSubviews[0] is UIButton, "First stackview arranged subview should be a UIButton")
    }
    
    func testStackViewContainsTwoViews() {
        XCTAssert(buttonStackView.arrangedSubviews.count == 2, "StackView should contain 2 subviews")
    }
    
    func testStackViewContainsTwoButtons() {
        XCTAssert(buttonStackView.arrangedSubviews[1] is UIButton, "Second stackview arranged subview should be a UIButton")
    }
    
    func testFirstButtonTitle() {
        guard let button = buttonStackView.arrangedSubviews[0] as? UIButton else { XCTFail("Root StackView first arranged subview is not a button"); return }
        
        XCTAssert(button.title(for: .normal) == "Add Apple", "Button title should be \"Add Apple\" but it is \(button.title(for: .normal))")
    }
    
    func testSecondButtonTitle() {
        guard let button = buttonStackView.arrangedSubviews[1] as? UIButton else { XCTFail("Root StackView first arranged subview is not a button"); return }
        
        XCTAssert(button.title(for: .normal) == "Add Orange", "Button title should be \"Add Orange\" but it is \(button.title(for: .normal))")
    }
    
    func testRootStackSetup() {
        XCTAssert(rootStackView.alignment == .fill, "Root stack view should be aligned to .fill")
        XCTAssert(rootStackView.axis == .vertical, "Root stack view axis should be vertical")
        XCTAssert(rootStackView.distribution == .fill, "The root stack view should fill")
        XCTAssert(rootStackView.spacing == 8, "Root stack view spacing should be 8")
    }
    
    func testButtonStackSetup() {
        XCTAssert(buttonStackView.distribution == .fillEqually, "Button stack view distribution should be .fillEqually")
        XCTAssert(buttonStackView.alignment == .top, "Button stack view alignment should be .top")
    }
    
    func testSummaryLabelSetup() {
        XCTAssert(summaryLabel.text == "", "Summary label text should be empty")
    }
    
    func testTotalLabelSetup() {
        XCTAssert(totalLabel.text == "0", "Total label text should be '0' to start with")
    }
    
    func testViewModel() {
        XCTAssertNotNil(vc.viewModel, "The view does not have a view model")
    }
}

FruitViewTests.defaultTestSuite.run()

class FruitModelTests: XCTestCase {
    
    var model: FruitModel!
    
    override func setUp() {
        super.setUp()
        
        model = FruitModel(delegate: self)
    }
    
    func testCanMakeModel() {
        XCTAssertNotNil(model, "Cannot create a model")
    }
    
    func testModelContainsFruitProperty() {
        XCTAssertNotNil(model.fruits, "Model does not have a 'fruits' property")
    }
    
    func testModelContainsNoFruitInitially() {
        XCTAssert(model.fruits.count == 0, "The 'fruits' property is not empty")
    }
    
    func testAddApple() {
        XCTAssert(model.fruits == [], "The 'fruits' property is not empty")
        
        model.addApple()
        
        XCTAssert(model.fruits == [.apple], "The 'fruits' property does not contain just a single apple")
    }
    
    func testAddOrange() {
        XCTAssert(model.fruits == [], "The 'fruits' property is not empty")
        
        model.addOrange()
        
        XCTAssert(model.fruits == [.orange], "The 'fruits' property does not contain just a single orange")
    }
    
    /*
    func testFruitCostExists() {
        XCTAssertNotNil(model.fruitCost, "The model does not have a 'fruitCost' property")
    }
    */
    
    /*
    func testAppleCost() {
        model.addApple()
        XCTAssert(model.fruitCost == 10, "The total fruit cost should now be 10")
    }
    */
    
    /*
    func testOrangeCost() {
        model.addOrange()
        XCTAssert(model.fruitCost == 12, "The total fruit cost should now be 12")
    }
    */
    
    /*
    func testAppleAndOrangeCost() {
        let targetCost = 22
        model.addApple()
        model.addOrange()
        XCTAssert(model.fruitCost == targetCost, "The total cost has not added together properly, it should be \(targetCost) but it is \(model.fruitCost)")
    }
    */
}

extension FruitModelTests: FruitModelDelegate {
    func fruitModelDidUpdate() {
        //
    }
    
    func fruitModelDidUpdate(to newModel: FruitModel) {
        //
    }
}

FruitModelTests.defaultTestSuite.run()

class FruitTests: XCTestCase {
    func testFruitExists() {
        XCTAssertNotNil(Fruit.apple, "Could not create an apple")
        XCTAssertNotNil(Fruit.orange, "Could not create an orange")
    }
    
    func testCostProperty() {
        XCTAssertNotNil(Fruit.apple.cost, "An apple does not have a 'cost' property")
        XCTAssertNotNil(Fruit.orange.cost, "An orange does not have a 'cost' property")
    }
    
    func testAppleCost() {
        XCTAssert(Fruit.apple.cost == 10, "An apple should cost 10p")
    }
    
    func testOrangeCost() {
        XCTAssert(Fruit.orange.cost == 12, "An orange should cost 12p")
    }
}

FruitTests.defaultTestSuite.run()

class FruitViewModelTests: XCTestCase {
    var viewModel: FruitViewModel!
    
    override func setUp() {
        super.setUp()
        
        viewModel = FruitViewModel(delegate: self)
    }
    
    func testViewModelExists() {
        XCTAssertNotNil(viewModel)
    }
    
    func testViewModelTotalCostExists() {
        XCTAssertNotNil(viewModel.totalCostLabelText)
    }
}

extension FruitViewModelTests: FruitViewModelDelegate {
    func fruitViewModelDidUpdate() {
        //
    }
}

FruitViewModelTests.defaultTestSuite.run()
