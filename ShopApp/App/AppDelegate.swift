//
//  AppDelegate.swift
//  ShopApp
//
//  Created by Ruslan Safargalin on 19.06.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    let requestFactory = RequestFactory()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        // MARK: Personal Area
        let personalArea: PersonalArea = requestFactory.fetchRequestFactory()
        personalArea.login(userName: "Somebody", password: "mypassword") { response in
            switch response.result {
            case .success(let login):
                print(login)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        Dispatch.sleep(2)
        
        personalArea.logout(userId: 123) { response in
            switch response.result {
            case .success(let logout):
                print(logout)
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        Dispatch.sleep(2)
        
        let userData = UserData(userId: 12, username: "geekbrains", password: "password", email: "geekbrains@mail.com", gender: "m", creditCard: "none", bio: "none")
        personalArea.checkIn(userData: userData) { response in
            switch response.result {
            case .success(let checkIn):
                print(checkIn)
                
            case .failure(let error):
                print(error)
            }
        }
        
        Dispatch.sleep(2)
        
        personalArea.changeData(userData: userData) { response in
            switch response.result {
            case .success(let changeData):
                print(changeData)
                
            case .failure(let error):
                print(error)
            }
        }
        
        Dispatch.sleep(2)
        
        // MARK: Catalog
    
        let catalog: Catalog = requestFactory.fetchRequestFactory()
        
        catalog.fetchAll { response in
            switch response.result {
            case .success(let products):
                print(products)
                
            case .failure(let error):
                print(error)
            }
        }
        
        Dispatch.sleep(2)
        
        catalog.fetchProduct(for: 123) { response in
            switch response.result {
            case .success(let product):
                print(product)
                
            case .failure(let error):
                print(error)
            }
        }
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

