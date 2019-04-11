//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

class QRCodeView: UIView {
    lazy var filter = CIFilter(name: "CIQRCodeGenerator")
    lazy var imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = bounds
    }
    
    func generateCode(_ string: String) {
        guard
            let filter = filter,
            let data = string.data(using: .isoLatin1, allowLossyConversion: false)
            else { return }
        
        filter.setValue(data, forKey: "inputMessage")
        filter.setValue("H", forKey: "inputCorrectionLevel")
        
        guard let ciImage = filter.outputImage else { return }
        
        let transformed = ciImage.transformed(by: CGAffineTransform(scaleX: 2, y: 2))
        
        imageView.image = UIImage(ciImage: transformed, scale: 2, orientation: .up)
    }
}

let qrView = QRCodeView(frame: CGRect(origin: .zero, size: CGSize(width: 500, height: 500)))
qrView.backgroundColor = .white
//qrView.generateCode("Hello, world")
/*
qrView.generateCode("""
{
"familyName": "Coleman",
"givenName": "James",
"dob": "1989-05-03"
}
""")
*/
//qrView.generateCode("https://www.linkedin.com/in/james-coleman-21276556?fromQR=1")
qrView.generateCode("Project Name")

// Present the view controller in the Live View window
PlaygroundPage.current.liveView = qrView

let dateFormatter = ISO8601DateFormatter()
let dateString = "1989-05-03"
dateFormatter.string(from: Date())
dateFormatter.formatOptions = [.withYear, .withMonth, .withDay, .withDashSeparatorInDate]
dateFormatter.string(from: Date())
dateFormatter.date(from: dateString)

