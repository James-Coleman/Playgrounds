import UIKit

let wordsUrl = Bundle.main.url(forResource: "google-10000-english-no-swears", withExtension: "txt")!
let words = try String(contentsOf: wordsUrl, encoding: .utf8)
let wordArray = words.components(separatedBy: .newlines)

let searchTerm = "jam"

let naieveSearch = Fuse().search(searchTerm, in: wordArray)
naieveSearch.count
let naieveSearchFirst = naieveSearch.first! // ! because you can't guard outside a function
naieveSearchFirst.index
naieveSearchFirst.score
naieveSearchFirst.ranges
wordArray[naieveSearchFirst.index]

let naieveSearchLast = naieveSearch.last!
naieveSearchLast.index
naieveSearchLast.score
wordArray[naieveSearchLast.index]

for testCase in 0..<10 {
    guard testCase < naieveSearch.count - 1 else { break }
    let result = naieveSearch[testCase]
    let word = wordArray[result.index]
}

let strictFuse = Fuse(threshold: 0.1)
let strictSearch = strictFuse.search(searchTerm, in: wordArray)
strictSearch.count

for testCase in 0..<15 {
    guard testCase < strictSearch.count else { break }
    let result = strictSearch[testCase]
    let word = wordArray[result.index] 
}

