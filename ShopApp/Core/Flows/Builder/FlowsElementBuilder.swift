//
//  FlowsElementBuilder.swift
//  ShopApp
//
//  Created by Ruslan Safargalin on 16.07.2021.
//

import Foundation
import UIKit

struct FlowsElementBuilder {
    
    // MARK: - Enums
    
    enum ViewsType {
        
        enum PersonalArea {
            case signUp,
                 changeData
        }
        
    }
    
    // MARK: - Public methods
    
    
    func buildViewPersonalArea(for type: ViewsType.PersonalArea) -> ContentView {
        
        switch type {
        case .signUp:
            return buildSignUpView()
            
        case .changeData:
            return buildChangeDataView()
        }
        
    }
    
    private func buildSignUpView() -> ChangeUserDataView {
        return ChangeUserDataView()
    }
    
    private func buildChangeDataView() -> ChangeUserDataView {
        let view = ChangeUserDataView()
        view.signUpButton.setTitle("Save", for: .normal)
        return view
    }
    
}
