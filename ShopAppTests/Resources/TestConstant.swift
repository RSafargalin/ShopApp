//
//  TestConstant.swift
//  ShopAppTests
//
//  Created by Ruslan Safargalin on 29.06.2021.
//

import Foundation

struct TestConstant {
    enum User {
        enum IntValues: Int {
            case id = 1
        }
        
        enum StringValues: String {
            case username = "LewisHamilton",
                 password = "stillirise",
                 email = "geekbrains@mail.com",
                 creditCard = "none",
                 bio = "no1ne"
        }
        
        func d() {}
    }
    
    enum Product {
        static let id: Int = 1
        static let name: String = "iPhone X"
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
