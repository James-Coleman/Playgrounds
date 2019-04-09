//: Playground - noun: a place where people can play

import UIKit

//let viableNumbers: [Int] = [1,2,3,4,5,6,7,8,9]
let viableNumbers: [Int] = [Int](1...9)

let example: [Int?] = [nil,2,3,4,5,6,7,8,9]

enum SudokuRowType {
    case row
    case column
    case square
}

enum SudokuError: Error {
    case countMismatch(shouldBe: Int, isActually: Int)
    case rowColumnSquareCountMismatch(goalCount: Int, rowCount: Int, columnCount: Int, squareCount: Int)
    case tooManyNils(count: Int)
    case unexpectedError(description: String)
    case tooManyDifferences(differentElements: [Int])
    case noNils
    case noNilsOf(type: SudokuRowType)
}

enum GenericSudokuError<T>: Error {
    case tooManyDifferences(differentElements: [T])
}

func singleLineSolver(input: [Int?], goal: [Int]) throws -> [Int] {
    guard input.count == goal.count else { throw SudokuError.countMismatch(shouldBe: goal.count, isActually: input.count) }
    
    let inputNils = input.filter { $0 == nil }
    let inputNilsCount = inputNils.count
    
    switch inputNilsCount {
    case 0:
        throw SudokuError.noNils
    case 1:
        break
    default:
        throw SudokuError.tooManyNils(count: inputNilsCount)
    }
    
    let existingInputs = input.compactMap { $0 }
    
    let missingNumbers = goal.filter( { !existingInputs.contains($0) })
    
    guard missingNumbers.count < 2 else { throw SudokuError.tooManyDifferences(differentElements: missingNumbers) }
    
    guard let missingNumber = missingNumbers.first else { throw SudokuError.unexpectedError(description: "There should be at least one number") }

    return input.compactMap { $0 == nil ? missingNumber : $0 }

//    let nextIteration = input.map { $0 == nil ? missingNumber : $0 }
//
//    return nextIteration
}

do {
//    let solution = try singleLineSolver(input: example, goal: viableNumbers)
//    print(solution)
} catch let error as SudokuError {
    print(error)
}

func genericSingleLineSolver<T: Equatable>(input: [T?], goal: [T]) throws -> [T] {
    guard input.count == goal.count else { throw SudokuError.countMismatch(shouldBe: goal.count, isActually: input.count) }
    
    let inputNils = input.filter { $0 == nil }
    let inputNilsCount = inputNils.count
    
    switch inputNilsCount {
    case 0:
        throw SudokuError.noNils
    case 1:
        break
    default:
        throw SudokuError.tooManyNils(count: inputNilsCount)
    }
    
    let existingInputs = input.compactMap { $0 }
    
    let missingNumbers = goal.filter({ goalObject -> Bool in
        return !existingInputs.contains(where: { inputObject -> Bool in
            return goalObject == inputObject
        })
    })
    
    guard missingNumbers.count <= 1 else { throw GenericSudokuError.tooManyDifferences(differentElements: missingNumbers) }

    guard let missingNumber = missingNumbers.first else { throw SudokuError.unexpectedError(description: "There should be at least one number") }

    return input.compactMap { $0 == nil ? missingNumber : $0 }
}

do {
//    try genericSingleLineSolver(input: [nil,2], goal: [1,2])
//    try genericSingleLineSolver(input: [nil,"b"], goal: ["a","b"])
//    try genericSingleLineSolver(input: example, goal: viableNumbers)
} catch {
    print(error)
}

/**
 
 Will start as a naive Int solver,
 might be upgraded to generic later.
 
 */
func singlePossibleNumber(goal: [Int], row: [Int?], column: [Int?], square: [Int?]) throws -> Int {
    let goalCount = goal.count
    guard goalCount == row.count, goalCount == column.count, goalCount == square.count else { throw SudokuError.rowColumnSquareCountMismatch(goalCount: goalCount, rowCount: row.count, columnCount: column.count, squareCount: square.count) }
    
    guard (row      .filter { $0 == nil }).count > 0 else { throw SudokuError.noNilsOf(type: .row) }
    guard (column   .filter { $0 == nil }).count > 0 else { throw SudokuError.noNilsOf(type: .column) }
    guard (square   .filter { $0 == nil }).count > 0 else { throw SudokuError.noNilsOf(type: .square) }
    
    let allArrays = row + column + square
    
    let noNilArray = allArrays.compactMap { $0 }
    
    let set = Set(noNilArray)
    
    let uniqueItems = Array(set)
    
    guard uniqueItems.count == goalCount - 1 else { throw SudokuError.tooManyNils(count: goalCount - uniqueItems.count) }
    
    let missingNumbers = goal.filter( { !uniqueItems.contains($0) })
    
    guard let missingNumber = missingNumbers.first else { throw SudokuError.unexpectedError(description: "There should be at least one number") }
    
    return missingNumber
}

do {
    try singlePossibleNumber(goal: viableNumbers, row: [1,2,3,nil,nil,nil,nil,nil,nil], column: [nil,nil,nil,4,5,6,nil,nil,nil], square: [nil,nil,nil,nil,nil,nil,7,8,nil])
} catch {
    print(error)
}


























