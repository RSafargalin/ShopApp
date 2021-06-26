//
//  Constant.swift
//  ShopApp
//
//  Created by Ruslan Safargalin on 25.06.2021.
//

import Foundation

struct Constant {
    enum PersonalArea {
        static let baseUrl: URL = URL(string: "https://raw.githubusercontent.com/GeekBrainsTutorial/online-store-api/master/responses/")!
        
        enum Parameters {
            static let userId: String = "user_id",
                       username: String = "username",
                       password: String = "password",
                       email: String = "email",
                       gender: String = "gender",
                       creditCard: String = "credit_card",
                       bio: String = "bio"
        }
        
        enum Login {
            static let path: String = "login.json"
        }
        
        enum Logout {
            static let path: String = "logout.json"
        }
        
        enum CheckIn {
            static let path: String = "registerUser.json"
        }
        
        enum ChangeData {
            static let path: String = "changeUserData.json"
        }
    }
    
}
