//
//  Auth.swift
//  ShopApp
//
//  Created by Ruslan Safargalin on 22.06.2021.
//

import Foundation
import Alamofire

class PersonalArea: AbstractRequestFactory {

    let errorParser: AbstractErrorParser
    let sessionManager: Session
    let queue: DispatchQueue
    let baseUrl = Constant.PersonalArea.baseUrl
    
    required init(errorParser: AbstractErrorParser, sessionManager: Session, queue: DispatchQueue = DispatchQueue.global(qos: .utility)) {
        self.errorParser = errorParser
        self.sessionManager = sessionManager
        self.queue = queue
    }
}

extension PersonalArea: PersonalAreaRequestFactory {
    func login(userName: String, password: String, completionHandler: @escaping (AFDataResponse<LoginResult>) -> Void) {
        let requestModel = Login(baseUrl: baseUrl, login: userName, password: password)
        self.request(request: requestModel, completionHandler: completionHandler)
    }

    func logout(userId: Int, completionHandler: @escaping (AFDataResponse<LogoutResult>) -> Void) {
        let requestModel = Logout(baseUrl: baseUrl, userId: userId)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    func checkIn(userData: UserData, completionHandler: @escaping (AFDataResponse<CheckInResult>) -> Void) {
        let requestModel = CheckIn(baseUrl: baseUrl, userData: userData)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    func changeData(userData: UserData, completionHandler: @escaping (AFDataResponse<ChangeDataResult>) -> Void) {
        let requestModel = ChangeData(baseUrl: baseUrl, userData: userData)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
}

extension PersonalArea {
    struct Login: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String = Constant.PersonalArea.Login.path
        
        let login: String
        let password: String
        var parameters: Parameters? {
            return [
                Constant.PersonalArea.Parameters.username: login,
                Constant.PersonalArea.Parameters.password: password
            ]
        }
    }
    
    struct Logout: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String = Constant.PersonalArea.Logout.path
        
        let userId: Int
        var parameters: Parameters? {
            return [
                Constant.PersonalArea.Parameters.userId: userId
            ]
        }
    }
    
    struct CheckIn: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String = Constant.PersonalArea.CheckIn.path
        
        let userData: UserData
        var parameters: Parameters? {
            return [
                Constant.PersonalArea.Parameters.userId: userData.userId,
                Constant.PersonalArea.Parameters.username: userData.username,
                Constant.PersonalArea.Parameters.password: userData.password,
                Constant.PersonalArea.Parameters.email: userData.email,
                Constant.PersonalArea.Parameters.gender: userData.gender,
                Constant.PersonalArea.Parameters.creditCard: userData.creditCard,
                Constant.PersonalArea.Parameters.bio: userData.bio
            ]
        }
    }
    
    struct ChangeData: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String = Constant.PersonalArea.ChangeData.path
        
        let userData: UserData
        var parameters: Parameters? {
            return [
                Constant.PersonalArea.Parameters.userId: userData.userId,
                Constant.PersonalArea.Parameters.username: userData.username,
                Constant.PersonalArea.Parameters.password: userData.password,
                Constant.PersonalArea.Parameters.email: userData.email,
                Constant.PersonalArea.Parameters.gender: userData.gender,
                Constant.PersonalArea.Parameters.creditCard: userData.creditCard,
                Constant.PersonalArea.Parameters.bio: userData.bio
            ]
        }
    }
}
