//
//  EButton.swift
//  ShopApp
//
//  Created by Ruslan Safargalin on 12.07.2021.
//

import Foundation
import UIKit

extension UIButton {
    
    enum ButtonState {
        case enabled,
             disabled
    }
    
    func set(_ state: ButtonState, enabledColor: UIColor = .accentColor, disabledColor: UIColor = .darkGray) {
        
        switch state {
        case .enabled:
            DispatchQueue.main.async {
                self.isEnabled = true
                self.backgroundColor = .accentColor
            }
            
        case .disabled:
            DispatchQueue.main.async {
                self.isEnabled = false
                self.backgroundColor = .darkGray
            }
        }
        
    }
    
}
