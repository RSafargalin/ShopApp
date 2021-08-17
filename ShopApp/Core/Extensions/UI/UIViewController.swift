//
//  UIViewController.swift
//  ShopApp
//
//  Created by Ruslan Safargalin on 21.07.2021.
//

import Foundation
import UIKit

extension UIViewController {
    
    func transformView<ViewType: UIView>(to type: ViewType.Type) -> ViewType {
        guard let view = self.view as? ViewType else {
            fatalError("It was not possible to bring the view type to the required one. Initializer called.")
        }
        
        return view
    }
    
}
