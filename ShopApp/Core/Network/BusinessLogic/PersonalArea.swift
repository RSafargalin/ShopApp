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
    
    func login(userName: String, password: String, completionHandler: @escaping (AFDataResponse<Response<SignInType>>) -> Void) {
        let requestModel = Login(baseUrl: baseUrl, login: userName, password: password)
        self.request(request: requestModel, completionHandler: completionHandler)
    }

    func logout(userId: Int, completionHandler: @escaping (AFDataResponse<Response<LogoutType>>) -> Void) {
        let requestModel = Logout(baseUrl: baseUrl, userId: userId)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    func checkIn(_ data: UserDataProtocol, completionHandler: @escaping (AFDataResponse<Response<SignUpType>>) -> Void) {
        let requestModel = CheckIn(baseUrl: baseUrl, userData: data)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    func changeData(_ user: UserProtocol, completionHandler: @escaping (AFDataResponse<Response<ChangeDataType>>) -> Void) {
        let requestModel = ChangeData(baseUrl: baseUrl, user: user)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
}

extension PersonalArea {
    struct Login: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String = Constant.PersonalArea.SignIn.path.rawValue
        
        let login: String
        let password: String
        var parameters: Parameters? {
            return [
                Constant.PersonalArea.Parameters.name.rawValue: login,
                Constant.PersonalArea.Parameters.password.rawValue: password
            ]
        }
    }
    
    struct Logout: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String = Constant.PersonalArea.Logout.path.rawValue
        
        let userId: Int
        var parameters: Parameters? {
            return [
                Constant.PersonalArea.Parameters.id.rawValue: userId
            ]
        }
    }
    
    struct CheckIn: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = Constant.PersonalArea.SignUp.path.rawValue
        
        let userData: UserDataProtocol
        var parameters: Parameters? {
            return [
                Constant.PersonalArea.Parameters.name.rawValue: userData.name,
                Constant.PersonalArea.Parameters.password.rawValue: userData.password,
                Constant.PersonalArea.Parameters.email.rawValue: userData.email,
                Constant.PersonalArea.Parameters.gender.rawValue: userData.gender,
                Constant.PersonalArea.Parameters.creditCard.rawValue: userData.creditCard,
                Constant.PersonalArea.Parameters.bio.rawValue: userData.bio
            ]
        }
    }
    
    struct ChangeData: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = Constant.PersonalArea.ChangeData.path.rawValue
        
        let user: UserProtocol
        var parameters: Parameters? {
            return [
                Constant.PersonalArea.Parameters.id.rawValue: user.id,
                Constant.PersonalArea.Parameters.name.rawValue: user.name,
                Constant.PersonalArea.Parameters.password.rawValue: user.password,
                Constant.PersonalArea.Parameters.email.rawValue: user.email,
                Constant.PersonalArea.Parameters.gender.rawValue: user.gender,
                Constant.PersonalArea.Parameters.creditCard.rawValue: user.creditCard,
                Constant.PersonalArea.Parameters.bio.rawValue: user.bio
            ]
        }
    }
}
