//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

class MyViewController : UIViewController {
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .white
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        
        /*
        let greenView = UIView()
        greenView.backgroundColor = .green
        scrollView.addSubview(greenView)
        greenView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            greenView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            greenView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            greenView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            greenView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
            ])
        
        greenView.heightAnchor.constraint(equalToConstant: 2000).isActive = true
        greenView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        */
        
//        scrollView.frame // Reported as 0, but greenview is visible so it's all good
//        greenView.frame
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 0
        stackView.distribution = .fill
        scrollView.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
//            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 2) // StackView is twice the width of the scroll (just for fun)
        ])
        
        for i in 0...20 {
            let greenView = UIView()
            greenView.backgroundColor = .green
            stackView.addArrangedSubview(greenView)
            greenView.translatesAutoresizingMaskIntoConstraints = false
            greenView.heightAnchor.constraint(equalToConstant: 100).isActive = true
            
            let label = UILabel()
            label.backgroundColor = .orange
            label.text = "I'm label \(i)"
            label.textAlignment = .center
            stackView.addArrangedSubview(label)
        }
    }
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
