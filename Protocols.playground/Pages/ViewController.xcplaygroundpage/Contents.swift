//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

protocol ErrorController {
    func setupError()
}

extension ErrorController where Self: UIViewController {
    func setupError() {
        view.backgroundColor = .red
    }
}

protocol CornerRadius {
    func setupRadius(_ radius: CGFloat)
}

extension CornerRadius where Self: UIViewController {
    func setupRadius(_ radius: CGFloat = 100) {
        view.layer.cornerRadius = radius
    }
}

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
        
        setupError()
        setupRadius()
    }
}

extension MyViewController: ErrorController, CornerRadius {
    
}

// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
