//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

class CustomCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 100)
        ])
        
        backgroundColor = .yellow
        
        if let font = UIFont(name: "Didot", size: 20) {
            textLabel?.font = font
        }
        
//        selectionStyle = .none
        
        let redView = UIView()
        redView.backgroundColor = .red
        
        selectedBackgroundView = redView
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    /*
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        if highlighted {
            backgroundColor = .blue
        } else {
            backgroundColor = .yellow
        }
    }
    */
    
}

class MyTableViewController: UITableViewController {
    let reuseIdentifier = "cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(CustomCell.self, forCellReuseIdentifier: reuseIdentifier)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as? CustomCell else { return UITableViewCell() }
        
        cell.textLabel?.text = "Row \(indexPath.row)"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // This will override the constant set in CustomCell init
    /*
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 10
    }
    */
    
}

// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyTableViewController()
