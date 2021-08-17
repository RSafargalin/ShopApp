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
    
    required init(errorParser: AbstractErrorParser,
                  sessionManager: Session,
                  queue: DispatchQueue = DispatchQueue.global(qos: .utility)) {
        
        self.errorParser = errorParser
        self.sessionManager = sessionManager
        self.queue = queue
        
    }
}

extension PersonalArea: PersonalAreaRequestFactory {
    
    func login(userName: String,
               password: String,
               completionHandler: @escaping (AFDataResponse<Response<SignInType>>) -> Void) {
        
        let requestModel = Login(baseUrl: baseUrl, login: userName, password: password)
        self.request(request: requestModel, completionHandler: completionHandler)
        
    }

    func logout(userId: Int,
                completionHandler: @escaping (AFDataResponse<Response<LogoutType>>) -> Void) {
        
        let requestModel = Logout(baseUrl: baseUrl, userId: userId)
        self.request(request: requestModel, completionHandler: completionHandler)
        
    }
    
    func checkIn(_ data: UserDataProtocol,
                 completionHandler: @escaping (AFDataResponse<Response<SignUpType>>) -> Void) {
        
        let requestModel = CheckIn(baseUrl: baseUrl, userData: data)
        self.request(request: requestModel, completionHandler: completionHandler)
        
    }
    
    func changeData(_ user: ChangeQueryData,
                    completionHandler: @escaping (AFDataResponse<Response<ChangeDataType>>) -> Void) {
        
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
                Constant.PersonalArea.Parameters.username.rawValue: login,
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
                Constant.PersonalArea.Parameters.username.rawValue: userData.username,
                Constant.PersonalArea.Parameters.password.rawValue: userData.password,
                Constant.PersonalArea.Parameters.firstName.rawValue: userData.firstName,
                Constant.PersonalArea.Parameters.surname.rawValue: userData.surname,
                Constant.PersonalArea.Parameters.email.rawValue: userData.email,
                Constant.PersonalArea.Parameters.gender.rawValue: userData.gender,
                Constant.PersonalArea.Parameters.creditCard.rawValue: userData.creditCard
            ]
        }
    }
    
    struct ChangeData: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = Constant.PersonalArea.ChangeData.path.rawValue
        
        let user: ChangeQueryData
        var parameters: Parameters? {
            
            var parameters: [String : Any] = [:]
            parameters.updateValue(user.id, forKey: Constant.PersonalArea.Parameters.id.rawValue)
            
            if let username = user.username {
                parameters.updateValue(username, forKey: Constant.PersonalArea.Parameters.username.rawValue)
            }
            
            if let password = user.password {
                parameters.updateValue(password, forKey: Constant.PersonalArea.Parameters.password.rawValue)
            }
            
            if let firstName = user.firstName {
                parameters.updateValue(firstName, forKey: Constant.PersonalArea.Parameters.firstName.rawValue)
            }
            
            if let surname = user.surname {
                parameters.updateValue(surname, forKey: Constant.PersonalArea.Parameters.surname.rawValue)
            }
            
            if let email = user.email {
                parameters.updateValue(email, forKey: Constant.PersonalArea.Parameters.email.rawValue)
            }
            
            if let creditCard = user.creditCard {
                parameters.updateValue(creditCard, forKey: Constant.PersonalArea.Parameters.creditCard.rawValue)
            }
            
            if let gender = user.gender {
                parameters.updateValue(gender, forKey: Constant.PersonalArea.Parameters.gender.rawValue)
            }
            
            return parameters
            
        }
    }
}
