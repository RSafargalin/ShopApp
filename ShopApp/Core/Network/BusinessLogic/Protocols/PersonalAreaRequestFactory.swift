//
//  PersonalAreaRequestFactory.swift
//  ShopApp
//
//  Created by Ruslan Safargalin on 22.06.2021.
//

import Foundation
import Alamofire

protocol PersonalAreaRequestFactory {
    
    func login(userName: String, password: String, completionHandler: @escaping (AFDataResponse<LoginResult>) -> Void)
    func logout(userId: Int, completionHandler: @escaping (AFDataResponse<LogoutResult>) -> Void)
    func checkIn(userData: UserData, completionHandler: @escaping (AFDataResponse<CheckInResult>) -> Void)
    func changeData(userData: UserData, completionHandler: @escaping (AFDataResponse<ChangeDataResult>) -> Void)
}

