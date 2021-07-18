//
//  Router.swift
//  ShopApp
//
//  Created by Ruslan Safargalin on 17.07.2021.
//

import Foundation
import UIKit

enum DisplayMode {
    case present,
         push,
         set
}

enum Screens {
    case SignIn,
         SignUp,
         UserProfile,
         ChangeData
}

protocol Router {
    
    func show(screen: Screens, with displayMode: DisplayMode, with navigationController: Bool)
    
}

class RouterImpl: Router {
    
    weak var controller: UIViewController?
    
    func show(screen: Screens, with displayMode: DisplayMode, with navigationController: Bool = false) {
        
        guard let controller = controller else { return }
        
        switch screen {
        case .SignIn:
//            controller.navigationController?.popToViewController(SignInViewController(), animated: true)
            show(SignInViewController.self, from: controller, with: displayMode, with: navigationController)
            
        case .SignUp:
            show(SignUpViewController.self, from: controller, with: displayMode, with: navigationController)
            
        case .ChangeData:
            show(UserChangeDataViewController.self, from: controller, with: displayMode, with: navigationController)
            
        case .UserProfile:
            show(UserProfileViewController.self, from: controller, with: displayMode, with: navigationController)
            
        @unknown default:
            show(SignInViewController.self, from: controller, with: .present, with: true)
        }
        
    }
    
    private func show<Screen>(_ screen: Screen.Type,
                      from controller: UIViewController,
                      with displayMode: DisplayMode,
                      with navigationController: Bool = false) where Screen : UIViewController {
        
        var screenController: Screen?
        let isUserChangeDataViewController = (screen is UserChangeDataViewController.Type)
        let isUserProfileViewController = (controller is UserProfileViewController)
        
        if isUserChangeDataViewController && isUserProfileViewController {
            screenController = UserChangeDataViewController(controller as! UserProfileViewControllerDelegate) as? Screen
        } else {
            screenController = Screen()
        }
        
        guard let safeScreenController = screenController else { return }
        
        switch displayMode {
        case .present:
            safeScreenController.modalPresentationStyle = .fullScreen
            
            if navigationController {
                
                let navigationController = UINavigationController(rootViewController: safeScreenController)
                navigationController.modalPresentationStyle = .fullScreen
                controller.present(navigationController, animated: true)
                
            } else {
                
                controller.present(safeScreenController, animated: true, completion: nil)
                
            }
            
        case .set:
            guard let currentNavController = controller.navigationController else { return }
            safeScreenController.modalPresentationStyle = .fullScreen
            
            if navigationController {
                
                let newNavigationController = UINavigationController(rootViewController: safeScreenController)
                newNavigationController.modalPresentationStyle = .fullScreen
                currentNavController.setViewControllers([newNavigationController], animated: true)
                
            } else {
                currentNavController.setViewControllers([safeScreenController], animated: true)
                
            }
            
        case .push:
            guard let navigationController = controller.navigationController else { return }
            navigationController.pushViewController(safeScreenController, animated: true)
        }
        
    }
    
    private func presentTabBar() {
        let userProfileController = UserProfileViewController()
        let navusercontroller = UINavigationController(rootViewController: userProfileController)
        userProfileController.title = "Profile"
        userProfileController.tabBarItem.image = UIImage(systemName: "person.fill")
        
        let catalogController = ProductsViewController()
        catalogController.title = "Catalog"
        catalogController.tabBarItem.image = UIImage(systemName: "cart.fill")
        let navcatalogcontroller = UINavigationController(rootViewController: catalogController)
        
        let tabBarController = UITabBarController()
        tabBarController.setViewControllers([navusercontroller, navcatalogcontroller], animated: false)
        tabBarController.modalPresentationStyle = .fullScreen
    }
    
    init(for controller: UIViewController) {
        self.controller = controller
    }
    
    deinit {
        controller = nil
    }
}
