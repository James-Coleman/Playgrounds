import UIKit

var str = "Hello, playground"

let range = NSRange(location: 0, length: str.utf16.count) // Uses utf16 to avoid issue with emoji

let regexPattern = try! NSRegularExpression(pattern: "play")
regexPattern.pattern

regexPattern.firstMatch(in: str, options: [], range: range)

extension NSRegularExpression {
    convenience init(_ pattern: String) {
        do {
            try self.init(pattern: pattern)
        } catch {
            preconditionFailure("Illegal regular expression: \(pattern)")
        }
    }

    func matches(_ string: String) -> Bool {
        let range = NSRange(location: 0, length: string.utf16.count)
        return firstMatch(in: string, options: [], range: range) != nil
    }
}

let newRegEx = NSRegularExpression("play")
newRegEx.matches(str)

extension String {
    static func ~= (lhs: String, rhs: String) -> Bool {
        guard let regex = try? NSRegularExpression(pattern: rhs) else { return false }
        let range = NSRange(location: 0, length: lhs.utf16.count)
        return regex.firstMatch(in: lhs, options: [], range: range) != nil
    }
}

str ~= "play"

"cad" ~= "ca[a-z]*d"

