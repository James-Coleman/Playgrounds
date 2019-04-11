import UIKit

let wordsUrl = Bundle.main.url(forResource: "google-10000-english-no-swears", withExtension: "txt")!
let words = try String(contentsOf: wordsUrl, encoding: .utf8)
let wordArray = words.components(separatedBy: .newlines)
let filteredArray = wordArray.filter { $0 != "" && $0.count > 5 }
let orderedWordArray = filteredArray.sorted()

let abandonedPredicate = NSPredicate(format: "SELF == 'abandoned'")
let abandonedResults = wordArray.filter { abandonedPredicate.evaluate(with: $0) }
abandonedResults

let containsPredicate = NSPredicate(format: "SELF CONTAINS 'deen'")
let containsResults = wordArray.filter { containsPredicate.evaluate(with: $0) }
containsResults

let dynamicPredicate = NSPredicate(format: "SELF == %@", "abilities")
let dynamicResults = wordArray.filter { dynamicPredicate.evaluate(with: $0) }
dynamicResults

let likePredicate = NSPredicate(format: "SELF LIKE %@", "abilit*")
let likeResults = wordArray.filter { likePredicate.evaluate(with: $0) }
likeResults


