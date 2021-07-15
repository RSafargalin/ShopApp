//
//  PersonalAreaRequestFactory.swift
//  ShopApp
//
//  Created by Ruslan Safargalin on 22.06.2021.
//

import Foundation
import Alamofire

protocol PersonalAreaRequestFactory {
    
    func login(userName: String, password: String, completionHandler: @escaping (AFDataResponse<Response<SignInType>>) -> Void)
    func logout(userId: Int, completionHandler: @escaping (AFDataResponse<Response<LogoutType>>) -> Void)
    func checkIn(_ data: UserDataProtocol, completionHandler: @escaping (AFDataResponse<Response<SignUpType>>) -> Void)
    func changeData(_ user: ChangeQueryData, completionHandler: @escaping (AFDataResponse<Response<ChangeDataType>>) -> Void)
}

