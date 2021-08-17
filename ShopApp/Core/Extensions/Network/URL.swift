//
//  URL.swift
//  ShopApp
//
//  Created by Ruslan Safargalin on 21.07.2021.
//

import Foundation
import Alamofire
import FirebaseCrashlytics

extension URL {
    
    static func getBaseURL() -> URL {
        let unSafeURL = URL(string: "https://vast-dusk-53457.herokuapp.com/")
        guard let safeURL = unSafeURL else {
            Crashlytics.crashlytics().setUserID(String(SessionData.shared.user.id))
            Crashlytics.crashlytics().log("Base URL is invalid. Can't create safe URL")
            fatalError(AFError.invalidURL(url: unSafeURL?.absoluteString ?? "Undefined URL").localizedDescription)
        }
        return safeURL
    }

}
