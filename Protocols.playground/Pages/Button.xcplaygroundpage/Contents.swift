import UIKit
import PlaygroundSupport

protocol CastsShadow {
    func applyShadow()
}

extension CastsShadow where Self: UIView {
    func applyShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 5)
        layer.shadowRadius = 5
        layer.shadowOpacity = 0.5
    }
}

protocol HasRoundedCorners {
    func roundCorners()
}

extension HasRoundedCorners where Self: UIView {
    func roundCorners() {
        layer.cornerRadius = 10
    }
}

protocol HasBorder {
    func applyBorder(colour: UIColor, width: CGFloat)
}

extension HasBorder where Self: UIView {
    func applyBorder(colour: UIColor = .white, width: CGFloat = 2) {
        layer.borderColor = colour.cgColor
        layer.borderWidth = width
    }
}

protocol HasText {
    func setText()
}

extension HasText where Self: UIButton {
    func setText() {
        titleLabel?.font = UIFont(name: "Times New Roman", size: (titleLabel?.font.pointSize)!)
    }
}

extension HasText where Self: UILabel {
    func setText() {
        font = UIFont(name: "Times New Roman", size: font.pointSize)
    }
}

class PrimaryButton: UIButton {
    init(frame: CGRect, text: String) {
        super.init(frame: frame)
        
        setTitle(text, for: .normal)
        backgroundColor = .orange
        
        roundCorners()
        applyBorder()
        setText()
        applyShadow()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

extension PrimaryButton: HasRoundedCorners, HasBorder, HasText, CastsShadow {}

class PrimaryLabel: UILabel {
    init(frame: CGRect, text: String) {
        super.init(frame: frame)
        
        self.text = text
        textColor = .white
        textAlignment = .center
        
        setText()
//        applyBorder()
//        roundCorners()
//        applyShadow()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

extension PrimaryLabel: HasText {}
//extension PrimaryLabel: HasText, HasBorder, HasRoundedCorners, CastsShadow {}

let view = UIView(frame: CGRect(x: 0, y: 0, width: 500, height: 500))
view.backgroundColor = .gray
view.addSubview(PrimaryButton(frame: CGRect(x: 150, y: 150, width: 200, height: 50), text: "Hello World"))
view.addSubview(PrimaryLabel(frame: CGRect(x: 150, y: 300, width: 200, height: 50), text: "Hello Label"))

PlaygroundPage.current.liveView = view

