//: Playground - noun: a place where people can play

import UIKit

enum CustomError: String, Error {
    case
    exampleError = "This is an example"
}

func throwingFunc() throws {
    guard "This" == "That" else { throw CustomError.exampleError }
}

do {
    try throwingFunc()
    print("Successfully passed func")
} catch let error as CustomError {
    print(error.rawValue)
}

enum ProperError: Error {
    case
    exampleError
}

extension ProperError: LocalizedError {
    var localizedDescription: String {
        switch self {
        case .exampleError:
            return "This is a proper error"
        }
    }
}

func properThrowingFunc() throws {
    throw ProperError.exampleError
}