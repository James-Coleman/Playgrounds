//: # N-Queens

import Foundation

/**
 Returns a string describing the input array in a visual style, allowing human eye debugging.
 
 - parameter array: The array to describe.
 - parameter queenCharacter: The character to use to show the presence of a Queen. Defaults to "Q".
 - parameter blankCharacter: The character to use to show the lack of a Queen (an empty space on the board). Defaults to "-".
 
 - returns: A string that can be printed to visually show the layout of the board.
 */
func intArrayDescription(of array: [Int], queenCharacter: Character = "Q", blankCharacter: Character = "-") -> String {
    var stringToReturn = ""
    
    for row in array {
        for (index, _) in array.enumerated() {
            if index == row {
                stringToReturn.append(queenCharacter)
            } else {
                stringToReturn.append(blankCharacter)
            }
        }
        stringToReturn += "\n"
    }
    
    return stringToReturn
}

//: This confirms that the intArrayDescription function works as expected.
//print(intArrayDescription(of: [1,2,0,3]))

/**
 Calculates and returns all legal solutions to the N-Queens problem.
 
 Does not filter symmetrical solutions (this could be built seperately).
 
 - parameter existingArrays: Arrays which have been calculated as being valid so far. These are used as seeds for the next generation. Defaults to an empty array.
 - parameter boardSize: The size of the board to calculate the solutions for. Defaults to 8.
 - parameter debug: Whether or not to print debug information as the function executes. Defaults to `false`.
 - parameter generation: Used to keep track of how large the arrays should be. This is only used internally, and should not be passed in externally.
 
 - returns: An array of arrays of valid solutions to the specified board size of the N-Queens problem.
 */
func nQueensSolutions(existingArrays: [[Int]] = [], boardSize: Int = 8, debug: Bool = false, generation: Int = 0) -> [[Int]] {
    if (existingArrays.first?.count ?? 0) == boardSize { return existingArrays } // Break the recursion if we have reached the desired boardsize.
    if generation > 0 && existingArrays.isEmpty { return existingArrays } // This will prevent runaway recursion if there are no solutions.
    
    var seeds: [[Int]] {
        if existingArrays.isEmpty {
            return [Int](0..<boardSize).map { [$0] }
        } else {
            return existingArrays
        }
    }
    
    if debug { print("Seeds:\n", seeds, "\n") }
    
    var arraysToReturn: [[Int]] = []
    
    outerLoop:
    for seed in seeds {
        mediumLoop:
        for newColumn in 0..<boardSize {
            innerLoop:
            for (row, column) in seed.enumerated() {
                if newColumn == column {
                    // Same column as existing Queen
                    if debug { print("Cannot append array \(seed) with \(newColumn) due to vertical conflict with \(column)") }
                    continue mediumLoop
                }
                
                let diffX = abs(newColumn - column)
                let diffY = abs(row - (seed.count))
                
                if diffX == diffY {
                    // Same diagonal as existing Queen
                    if debug { print("Cannot append array \(seed) with \(newColumn) due to diagonal conflict with \(column)") }
                    continue mediumLoop
                }
            }
            
            // If you got this far, it's safe to add a new Queen in this position
            
            let newArray = seed + [newColumn]
            arraysToReturn += [newArray]
        }
    }
    
    if debug { print("New arrays:\n", arraysToReturn, "\n") }
    
    
    return nQueensSolutions(existingArrays: arraysToReturn, boardSize: boardSize, debug: debug, generation: generation + 1)
}

let eightQueensSolution = nQueensSolutions()
eightQueensSolution.forEach { print(intArrayDescription(of: $0)) }
print(eightQueensSolution.count) // Returns 92 (correct for all permutations, this does not filter symmetrical permutations)

nQueensSolutions(boardSize: 2).count // Returns  0 (correct)
nQueensSolutions(boardSize: 3).count // Returns  0 (correct)
nQueensSolutions(boardSize: 4).count // Returns  2 (correct)
nQueensSolutions(boardSize: 5).count // Returns 10 (correct)
nQueensSolutions(boardSize: 6).count // Returns  4 (correct)
nQueensSolutions(boardSize: 7).count // Returns 40 (correct)

//: Answers confirmed via [WikiPedia](https://en.wikipedia.org/wiki/Eight_queens_puzzle)

