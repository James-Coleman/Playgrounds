import UIKit

let str = "Hello, playground"

var atrStr = NSAttributedString(string: str)

let font = UIFont.systemFont(ofSize: 72)
var attributes: [NSAttributedString.Key: Any] = [.font: font]
atrStr = NSAttributedString(string: str, attributes: attributes)

attributes = [.font: font, .foregroundColor: UIColor.red]
atrStr = NSAttributedString(string: str, attributes: attributes)

let shadow = NSShadow()
shadow.shadowColor = UIColor.red
shadow.shadowBlurRadius = 5

attributes = [.font: font, .foregroundColor: UIColor.white, .shadow: shadow]
atrStr = NSAttributedString(string: str, attributes: attributes)

let paragraphStyle = NSMutableParagraphStyle()
paragraphStyle.alignment = .center
paragraphStyle.firstLineHeadIndent = 5

attributes = [.font: font, .foregroundColor: UIColor.blue, .paragraphStyle: paragraphStyle]
atrStr = NSAttributedString(string: str, attributes: attributes)

let mutableAtrStr = NSMutableAttributedString(string: str)
mutableAtrStr.addAttribute(.foregroundColor, value: UIColor.red, range: NSRange(location: 7, length: 5))

attributes = [.backgroundColor: UIColor.green, .kern: 10]
mutableAtrStr.addAttributes(attributes, range: NSRange(location: 0, length: 6))

let firstAttributes: [NSAttributedString.Key: Any] = [.backgroundColor: UIColor.green, .kern: 10]
let secondAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.red]

let firstString = NSMutableAttributedString(string: "First ", attributes: firstAttributes)
let secondString = NSAttributedString(string: "second ", attributes: secondAttributes)
let thirdString = NSAttributedString(string: "third")

firstString.append(secondString)
firstString.append(thirdString)

let html = """
<html>
<body>
<p style="color: blue;">This is blue!</p>
</body>
</html>
"""

let data = Data(html.utf8)

if let attributedString = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
    attributedString
}

let sentence = "the cat sat on the mat"
let regularAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)]
let largeAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 24)]
let attributedSentence = NSMutableAttributedString(string: sentence, attributes: regularAttributes)

attributedSentence.setAttributes(largeAttributes, range: NSRange(location: 4, length: 3))
attributedSentence.setAttributes(largeAttributes, range: NSRange(location: 12, length: 2))
attributedSentence.setAttributes(largeAttributes, range: NSRange(location: 19, length: 3))

// If the font is bold, also make it red
attributedSentence.enumerateAttribute(.font, in: NSRange(0..<attributedSentence.length)) { (value, range, stop) in
    if let valueFont = value as? UIFont {
        if valueFont.fontDescriptor.symbolicTraits.contains(.traitBold) {
            attributedSentence.addAttribute(.foregroundColor, value: UIColor.red, range: range)
        }
    }
}

attributedSentence

let image = UIImage(named: "Swift_logo.svg")
let imageString = NSMutableAttributedString(string: "Swift logo: ")
let imageAttachment = NSTextAttachment()
imageAttachment.image = image
imageAttachment.image

let imageAttachmentString = NSAttributedString(attachment: imageAttachment)
imageAttachmentString.length
imageAttachmentString.containsAttachments(in: NSRange(0..<imageAttachmentString.length))
imageString
imageString.append(imageAttachmentString)

imageString
imageString.containsAttachments(in: NSRange(0..<imageString.length))

let label = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
label.attributedText = imageString

let soninLink = NSMutableAttributedString(string: "Sonin")
soninLink.addAttribute(.link, value: "www.sonin.agency", range: NSRange(0..<soninLink.length))
