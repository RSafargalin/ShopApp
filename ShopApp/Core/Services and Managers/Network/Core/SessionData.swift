//
//  SessionData.swift
//  ShopApp
//
//  Created by Ruslan Safargalin on 10.07.2021.
//

import Foundation

struct SessionData {
    
    static var shared: SessionData = SessionData()
    private init() {}
    
    var user: User = User(id: -1,
                          username: "username",
                          password: "password",
                          firstName: "firstName",
                          surname: "surname",
                          email: "stub@email.com",
                          gender: false,
                          creditCard: "none",
                          cart: [:])

    enum RegularExpressions {
        static let IntAndNotZero = ValidationManager().fetchRegularExpression(for: .IntAndNotZero)
    }
    
}
