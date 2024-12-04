//
//  PlayerData.swift
//  iOS_Ultimate_FPL
//
//  Created by Hashirul Quadir on 10/24/24.
//

import SwiftUI
import Foundation

// Define a struct for Person
struct Person: Codable { // Conform to Codable (which includes Decodable)
    let name: String
    let shirtName: String
}


// Define players for each position
let FWD: [Person] = [
    Person(name: "Player", shirtName: "default-shirt"),
    Person(name: "Player", shirtName: "default-shirt"),
    Person(name: "Player", shirtName: "default-shirt")
]

let MID: [Person] = [
    Person(name: "Player", shirtName: "default-shirt"),
    Person(name: "Player", shirtName: "default-shirt"),
    Person(name: "Player", shirtName: "default-shirt")
]

let DEF: [Person] = [
    Person(name: "Player", shirtName: "default-shirt"),
    Person(name: "Player", shirtName: "default-shirt"),
    Person(name: "Player", shirtName: "default-shirt"),
    Person(name: "Player", shirtName: "default-shirt")
]

let GK: Person = Person(name: "Player", shirtName: "default-shirt")
