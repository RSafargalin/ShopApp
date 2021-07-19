//
//  FlowsBuilder.swift
//  ShopApp
//
//  Created by Ruslan Safargalin on 19.07.2021.
//

import Foundation
import UIKit

enum FlowsType {
    
    case UserProfile,
         Catalog,
         MainTabBar(_ viewControllers: [UIViewController])
    
}

protocol FlowsBuilder {
    
    func build(flow type: FlowsType) -> UIViewController
    
}

class FlowsBuilderImpl: FlowsBuilder {
    
    func build(flow type: FlowsType) -> UIViewController {
        switch type {
        case .UserProfile:
            let userProfileController = UserProfileViewController()
            let userProfileNavigationController = NavController(rootViewController: userProfileController)
            userProfileController.tabBarItem.image = UIImage(systemName: "person.fill")
            userProfileController.tabBarItem.title = "Profile"
            return userProfileNavigationController
             
        case .Catalog:
            let catalogController = ProductsViewController()
            catalogController.tabBarItem.title = "Catalog"
            catalogController.tabBarItem.image = UIImage(systemName: "cart.fill")
            let catalogNavigationController = NavController(rootViewController: catalogController)
            return catalogNavigationController
            
        case .MainTabBar(let viewControllers):
            let mainTabBarController = UITabBarController()
            mainTabBarController.setViewControllers(viewControllers, animated: false)
            mainTabBarController.modalPresentationStyle = .fullScreen
            return mainTabBarController
        }
    }
    
}
