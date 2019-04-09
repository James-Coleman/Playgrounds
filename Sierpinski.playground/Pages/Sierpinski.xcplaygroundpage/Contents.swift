import UIKit

class Triangle: UIView {
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
        let path = UIBezierPath()
        
        
    }
}
