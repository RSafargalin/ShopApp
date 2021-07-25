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
         ChangeData,
         MainTabBar,
         Profile(product: Product)
}

protocol Router {
    
    func show(screen: Screens, with displayMode: DisplayMode, with navigationController: Bool)
    
}

class RouterImpl: Router {
    
    // MARK: - Private Variables
    
    private weak var controller: UIViewController?
    private let flowsBuilder: FlowsBuilder = FlowsBuilderImpl()
    
    // MARK: -  Public Methods
    
    func show(screen: Screens, with displayMode: DisplayMode, with navigationController: Bool = false) {
        
        guard let controller = controller else { return }
        
        switch screen {
        case .SignIn:
            show(SignInViewController.self, from: controller, with: displayMode, with: navigationController)
            
        case .SignUp:
            show(SignUpViewController.self, from: controller, with: displayMode, with: navigationController)
            
        case .ChangeData:
            show(UserChangeDataViewController.self, from: controller, with: displayMode, with: navigationController)
            
        case .UserProfile:
            show(UserProfileViewController.self, from: controller, with: displayMode, with: navigationController)
            
        case .MainTabBar:
            controller.navigationController?.present(presentTabBar(), animated: true) { [weak self] in
                controller.navigationController?.setViewControllers([], animated: false)
                UIApplication.shared.windows.first?.rootViewController = self?.presentTabBar()
                
            }
            
        case .Profile(let product):
            let profileController = ProductProfileViewController(product: product)
            controller.navigationController?.pushViewController(profileController, animated: true)
//            show(ProductProfileViewController.self, from: controller, with: displayMode, with: navigationController)
        }
        
    }
    
    // MARK: - Private Methods
    
    private func show<Screen>(_ screen: Screen.Type,
                      from controller: UIViewController,
                      with displayMode: DisplayMode,
                      with navigationController: Bool = false) where Screen : UIViewController {
        
        var screenController: Screen?
        let isUserChangeDataViewController = (screen is UserChangeDataViewController.Type)
        let isUserProfileViewController = (controller is UserProfileViewController)
        
        if isUserChangeDataViewController && isUserProfileViewController {
            guard let userProfileViewController = controller as? UserProfileViewControllerDelegate,
                  let safeScreenController = UserChangeDataViewController(userProfileViewController) as? Screen
            else {
                screenController = Screen()
                return
            }
            
            screenController = safeScreenController
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
    
    private func presentTabBar() -> UITabBarController {
        
        let userProfileController = flowsBuilder.build(flow: .UserProfile)
        let catalogController = flowsBuilder.build(flow: .Catalog)
        let cartController = flowsBuilder.build(flow: .Cart)
        
        guard let mainTabBarController = flowsBuilder
                .build(flow: .MainTabBar([userProfileController, catalogController, cartController])) as? UITabBarController
        else { return UITabBarController() }
        
        return mainTabBarController
        
    }
    
    init(for controller: UIViewController) {
        self.controller = controller
    }
    
    deinit {
        controller = nil
    }
}
