//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

class MyViewController : UIViewController {
    
    @objc
    func pressedButton() {
        print("pressed button")
    }
    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white

        let label = UILabel()
        label.frame = CGRect(x: 150, y: 200, width: 200, height: 20)
        label.text = "Hello World!"
        label.textColor = .black
        
        view.addSubview(label)
        
        let button = UIButton(frame: CGRect(x: 150, y: 240, width: 200, height: 40))
        button.addTarget(self, action: #selector(pressedButton), for: .touchUpInside)
        button.setTitle("heelo", for: .normal)
        button.backgroundColor = .blue
        button.tintColor
        button.currentTitleColor
        button.buttonType
        button.frame
        
        view.addSubview(button)
        
        self.view = view
    }
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
