//
//  UserCaretaker.swift
//  ShopApp
//
//  Created by Ruslan Safargalin on 15.07.2021.
//

import Foundation

class UserCaretaker {
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    private let key = "user"
    
    func save(_ user: User) {
        
        do {
            let data = try self.encoder.encode(user)
            UserDefaults.standard.set(data, forKey: key)
        } catch {
            logging(error.localizedDescription)
        }
        
    }
    
    func retrieveUser() -> User? {
        
        guard let data = UserDefaults.standard.data(forKey: key)
        else { return nil }
        
        do {
            return try self.decoder.decode(User.self, from: data)
        } catch {
            logging(error.localizedDescription)
            return nil
        }
        
    }
}
