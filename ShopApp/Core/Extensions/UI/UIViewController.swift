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
        
        if let view = self.view as? ViewType {
            return view
        } else {
            return type.init(frame: self.view.frame)
        }
        
    }
    
}
