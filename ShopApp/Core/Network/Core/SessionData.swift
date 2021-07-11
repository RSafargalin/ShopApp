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
    
    var user: User = User(id: 1,
                          name: "LewisHamilton",
                          password: "stillirise",
                          email: "stub@email.com",
                          gender: false,
                          creditCard: "none",
                          bio: "none",
                          cart: [:])
}
