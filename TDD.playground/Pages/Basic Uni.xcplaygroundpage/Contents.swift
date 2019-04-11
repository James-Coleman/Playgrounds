import UIKit

struct Model {
     var delegate: ModelDelegate
    
    public private(set) var number: Int = 0 {
        didSet {
            number
//            delegate.modelDidUpdate()
        }
    }
    
    mutating public func incrementNumber() {
        number += 1
    }
    
    public mutating func resetNumber() {
        number = 0
    }
    
    init(delegate: ModelDelegate) {
        self.delegate = delegate
    }
}

protocol ModelDelegate {
    func modelDidUpdate()
}

struct ViewModel {
    var model: Model {
        didSet {
            model.number
            model.delegate.modelDidUpdate()
        }
    }
    
    var stringForLabel: String {
        return "\(model.number)"
    }
    
    public mutating func tappedAdd() {
        model.incrementNumber()
    }
    
    public mutating func tappedReset() {
        model.resetNumber()
    }
    
    init(modelDelegate: ModelDelegate) {
        self.model = Model(delegate: modelDelegate)
    }
}

class MyView: UIView {
    lazy var viewModel: ViewModel = {
        return ViewModel(modelDelegate: self)
    }()
    
    var label: UILabel!
    
    @objc private func tappedAddButton() {
        viewModel.tappedAdd()
    }
    
    @objc private func tappedResetButton() {
        viewModel.tappedReset()
    }
    
    private func updateView() {
        viewModel.model.number
        label.text = viewModel.stringForLabel
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let addButton = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        addButton.setTitle("+", for: .normal)
        addButton.addTarget(self, action: #selector(tappedAddButton), for: .touchUpInside)
        addSubview(addButton)
        
        let resetButton = UIButton(frame: CGRect(x: 100, y: 0, width: 100, height: 100))
        resetButton.setTitle("Reset", for: .normal)
        resetButton.addTarget(self, action: #selector(tappedResetButton), for: .touchUpInside)
        addSubview(resetButton)
        
        let label = UILabel(frame: CGRect(x: 0, y: 100, width: 200, height: 100))
        label.textColor = .white
        label.textAlignment = .center
        addSubview(label)
        self.label = label
        
        updateView()
    }
}

extension MyView: ModelDelegate {
    func modelDidUpdate() {
        updateView()
    }
}

import PlaygroundSupport

let myView = MyView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))

PlaygroundPage.current.liveView = myView
