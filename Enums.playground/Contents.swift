//: Playground - noun: a place where people can play

import UIKit

enum ExampleSegueIDs: String {
    case first
}

extension ExampleSegueIDs {
//    case second // enum 'case' is not allowed outside of an enum
}

print(ExampleSegueIDs.first.rawValue)

/*
 
 This StackOverflow has a weird idea to use a struct as an enum, I don't think I like it: https://stackoverflow.com/questions/34025674/adding-a-case-to-an-existing-enum-with-a-protocol
 
 */
