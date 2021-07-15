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
                          username: "LewisHamilton",
                          password: "stillirise",
                          firstName: "Lewis",
                          surname: "Hamilton",
                          email: "stub@email.com",
                          gender: false,
                          creditCard: "none",
                          cart: [:])
}
