import Foundation

struct UserManager {
    static let userKey = "userCredentials"
    
    struct UserCredentials: Codable {
        var email: String
        var password: String
    }
    
    static func saveUser(_ user: UserCredentials) {
        if let encoded = try? JSONEncoder().encode(user) {
            UserDefaults.standard.set(encoded, forKey: userKey)
        }
    }
    
    static func getUser() -> UserCredentials? {
        if let data = UserDefaults.standard.data(forKey: userKey),
           let user = try? JSONDecoder().decode(UserCredentials.self, from: data) {
            return user
        }
        return nil
    }
}
//
//  UserManager.swift
//  iOS_Ultamite_FPL
//
//  Created by Hashirul Quadir on 10/22/24.
//

