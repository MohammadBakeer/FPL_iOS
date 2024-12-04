//
//  SharedModels.swift
//  iOS_Ultamite_FPL
//
//  Created by Mohammad Bakeer on 12/3/24.
//

import Foundation

struct Team: Codable {
    var formation: [String]
    var playerLineup: [Player]
    var totalBudget: Double
    var points: Int
    var deleteCount: Int
    var changeCount: Int
}

struct Player: Identifiable, Codable {
    var id = UUID()
    var name: String
    var shirtName: String
    var price: Double
    var position: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case shirtName
        case price
        case position
    }
    
    // Custom initializer to convert price from String to Double
    init(name: String, shirtName: String, price: Double, position: String) {
        self.name = name
        self.shirtName = shirtName
        self.price = Double(price) ?? 0.0 // Convert price from String to Double, default to 0.0 if conversion fails
        self.position = position
    }
}


