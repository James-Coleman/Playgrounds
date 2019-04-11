import UIKit

extension String {
    func index(of pattern: String) -> Index? {
        for i in indices {
            var j = i
            var found = true
            for p in pattern.indices {
                guard j != endIndex && self[j] == pattern[p] else { found = false; break }
                j = index(after: j)
            }
            if found {
                return i
            }
        }
        return nil
    }
    
}

let text = "HELLO WORLD"
text.index(of: "ELLO")?.encodedOffset
text.index(of: "LD")?.encodedOffset
