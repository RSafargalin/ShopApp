//
//  Constant.swift
//  ShopApp
//
//  Created by Ruslan Safargalin on 25.06.2021.
//

import Foundation

struct Constant {
    
    // MARK: Personal Area
    
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
    
    // MARK: Catalog
    
    enum Catalog {
        static let baseUrl: URL = URL(string: "https://raw.githubusercontent.com/GeekBrainsTutorial/online-store-api/master/responses/")!
        
        enum Products {
            static let path: String = "catalogData.json"
        }
        
        enum Product {
            static let path: String = "getGoodById.json"
        }
        
        enum Parameters {
            static let id: String = "id_product"
        }
    }
}
