import Foundation

enum Style: CaseIterable {
    case camel, kebab, underscore
}

enum Capitalisation: CaseIterable {
    case lower, upper, title
}

extension String {
    var wordSet: Set<String.SubSequence> {
        let lowerCase = self.lowercased()
        let noReturns = lowerCase.replacingOccurrences(of: "\n", with: ",")
        let noSpacesAfterCommas = noReturns.replacingOccurrences(of: ", ", with: ",")
        let array = noSpacesAfterCommas.split(separator: ",")
        let set = Set(array) // Ensures there are no duplicates to prevent bias in the randomElement
        
        return set
    }
    
    /**
     Removes capitalisation, then removes new lines, then removes spaces after commas, then splits on commas, then returns a random element.
     Will be an empty string if it can't return a random element.
    */
    var randomWord: Substring {
        return wordSet.randomElement() ?? ""
    }
    
    var wordCount: Int {
        return wordSet.count
    }
    
    func styledFor(_ style: Style, _ capitalisation: Capitalisation) -> String {
        let split = self.split(separator: " ")
        
        var seperator: String {
            switch style {
            case .camel:
                return ""
            case .kebab:
                return "-"
            case .underscore:
                return "_"
            }
        }
        
        let styled = split.enumerated().map({ (offset, element) -> String in
            switch (style, capitalisation) {
            case (.camel, .lower):
                if offset == 0 {
                    return String(element)
                } else {
                    return element.capitalized
                }
            case (.camel, .upper), (.camel, .title):
                return element.capitalized
            case (_, .lower):
                return String(element) // already lowercase
            case (_, .upper):
                return element.uppercased()
            case (_, .title):
                return element.capitalized
            }
        })
        
        return styled.joined(separator: seperator)
    }
}

let determiners = """
a, every, her, his, my, the, their, this, your
"""

//determiners.randomWord

/// Deliberately does not include "white", "black", or "brown" to avoid racial connotations
let colours = """
red, orange, yellow, green, blue, indigo, violet
cyan, magenta, yellow
grey, pink, turquiose
""" // .randomWord will remove duplicates, even if a different capitalisation (must be different spelling).

//colours.randomWord

let speed = """
fast, quick, rapid, slow
"""

let behaviour = """
baffled, cheeky, confused, defeated, excited, fruity, jovial, kind, magestic, nice, polite, shy
"""

let naughtyBehaviour = """
horrible, mean, mischievous, naughty, terrible, unkind, upsetting, violent
"""

let descriptors = """
beautiful, bloated, boring, devilish, intelligent, irritable, fantastic, majestic, mundane, regal, unhappy, vigorous
"""

let naughtyDescriptors = """
dumb, stupid, ugly
"""

let physicalDescriptors = """
chubby, fat, fit, lazy, muscular, unfit
"""

let adjectives = [colours, speed, behaviour, descriptors, physicalDescriptors].joined(separator: ",")

adjectives.randomWord
adjectives.wordCount

let animals = """
aardvark, anteater, badger, bat, beaver, cat, canary, degu, dog, donkey, elephant, fish, fly, fox, gerbil, giraffe, gnat, goat, guinea pig, hamster, hare, hippo, hippopotamus, iguana, jackrabbit, kangeroo, kiwi, lizard, lemur, llama, mammal, mole, mouse, otter, peacock, quail, rabbit, ray, rhino, rhinoceros, salamander, serpent, snake, spider, stoat, weasel, wombat, worm, yak, zebra
"""

let fantasyCreatures = """
angel, demon, centaur, dragon, elf, fairy, ghost, goblin, mermaid, orc, phantom, phoenix, spectre, unicorn, warlock, witch, wizard
"""

let jobs = """
babysitter, baker, begger, butcher, candlestick maker, clown, coder, dentist, designer, developer, doctor, electrician, engineer, firefighter, gynaecologist, mechanic, midwife, nurse, operator, optician, paramedic, pilot, programmer, radiologist, receptionist, soldier, solicitor, technician, thief
"""

let relatives = """
aunt, brother, cousin, dad, daddy, father, gran, grandad, grandmother, granny, mother, mum, mummy, nan, nanny, nephew, niece, sister, uncle
"""

let nouns = [animals, fantasyCreatures, jobs, relatives].joined(separator: ",")

nouns.wordCount

let adverbs = """
bravely, carefully, quickly, slowly
"""

let verbs = """
bounds, jumps, leaps, runs, slips, sprints, walks
"""

let prepositions = """
behind, near, on top of, over, to the side of, under, underneath
"""

func password(withAdverb: Bool = false) -> String {
    let determiner1 = determiners   .randomWord
    let adjective1  = adjectives    .randomWord
    var adjective2  = adjectives    .randomWord
    let noun1       = nouns         .randomWord
    let adverb      = withAdverb ? adverbs.randomWord : ""
    let verb        = verbs         .randomWord
    let preposition = prepositions  .randomWord
    let determiner2 = determiners   .randomWord
    var adjective3  = adjectives    .randomWord
    var noun2       = nouns         .randomWord
    
    // Remove possible duplicates
    
    while adjective2 == adjective1 {
        adjective2  = adjectives    .randomWord
    }
    
    while adjective3 == adjective1 || adjective3 == adjective2 {
        adjective3  = adjectives    .randomWord
    }
    
    while noun2 == noun1 {
        noun2       = nouns         .randomWord
    }
    
    let wordsAsSentance = [determiner1, adjective1, adjective2, noun1, adverb, verb, preposition, determiner2, adjective3, noun2].joined(separator: " ")
    
    guard
        let style = Style.allCases.randomElement(),
        let capitalisation = Capitalisation.allCases.randomElement()
        else { return "" }
    
    return wordsAsSentance.styledFor(style, capitalisation)
}

password()
password(withAdverb: true)

var simplePassword: String {
    let adjective1 = adjectives .randomWord
    var adjective2 = adjectives .randomWord
    let noun       = nouns      .randomWord
    
    // Remove possible duplicates
    
    while adjective2 == adjective1 {
        adjective2  = adjectives    .randomWord
    }
    
    let wordsAsSentance = [adjective1, adjective2, noun].joined(separator: " ")
    
    guard
        let style = Style.allCases.randomElement(),
        let capitalisation = Capitalisation.allCases.randomElement()
        else { return "" }
    
    return wordsAsSentance.styledFor(style, capitalisation)
}

simplePassword // Shortest possible is still likely to be 9 characers e.g. "shyRedFox"
