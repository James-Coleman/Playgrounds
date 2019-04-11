//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

class Person: NSObject {
    let firstName: String
    let lastName: String
    let age: Int
    
    init(firstName: String, lastName: String, age: Int) {
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
    }
    
    override var description: String {
        return "\(firstName) \(lastName)"
    }
}

let alice = Person(firstName: "Alice", lastName: "Smith", age: 24)
let bob = Person(firstName: "Bob", lastName: "Jones", age: 27)
let charlie = Person(firstName: "Charlie", lastName: "Smith", age: 33)
let quentin = Person(firstName: "Quentin", lastName: "Alberts", age: 31)
let people = [alice, bob, charlie, quentin] as NSArray

let ageIs33Predicate01 = NSPredicate(format: "age = 33")
let ageIs33Predicate02 = NSPredicate(format: "%K = 33", "age")

//(people as NSArray).filtered(using: ageIs33Predicate01)
//// ["Charlie Smith"]
//
//(people as NSArray).filtered(using: ageIs33Predicate02)

people.filtered(using: NSPredicate(format: "firstName LIKE %@", "Al?ce")) // A question mark (?) acts as a wild card
people.filtered(using: NSPredicate(format: "firstName LIKE %@", "*e*")) // An asterisk (*) can account for 0 or more characters

let firstNamePredicate = NSPredicate(format: "firstName LIKE %@", "Al*")
let lastNamePredicate = NSPredicate(format: "lastName LIKE %@", "Al*")

people.filtered(using: NSCompoundPredicate(orPredicateWithSubpredicates: [firstNamePredicate, lastNamePredicate]))