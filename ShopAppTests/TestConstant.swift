//
//  TestConstant.swift
//  ShopAppTests
//
//  Created by Ruslan Safargalin on 29.06.2021.
//

import Foundation

struct TestConstant {
    enum User {
        static let userId: Int = 123
        static let username: String = "Somebody"
        static let password: String = "mypassword"
        static let email: String = "geekbrains@mail.com"
        static let gender: String = "m"
        static let creditCard: String = "none"
        static let bio: String = "none"
    }
    
    enum Product {
        static let id: Int = 123
        static let name: String = "Ноутбук"
    }
    
    enum Server {
        enum Response {
            static let goodResultCode: Int = 1
        }
        
        enum WaitTime: TimeInterval {
            case ten = 10
        }
    }
}
