//
//  UserProfileViewController.swift
//  ShopApp
//
//  Created by Ruslan Safargalin on 15.07.2021.
//

import Foundation
import UIKit

protocol UserProfileViewControllerDelegate {
    func updateUserData()
}

class UserProfileViewController: UIViewController {

    // MARK: - Private properties
    
    private let personalArea: PersonalArea
    private var contentView: UserProfileView {
        return self.view as! UserProfileView
    }
    
    // MARK: - Life cycle
    
    override func loadView() {
        self.view = UserProfileView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    // MARK: - Init
    
    init() {
        
        let requestFactory = RequestFactory()
        personalArea = requestFactory.fetchRequestFactory()
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    
    func setup() {
        
        let user = SessionData.shared.user
        self.navigationItem.title = "\(user.firstName) \(user.surname)"
        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.prompt = user.username
        
        contentView.setGender(user.gender)
        contentView.setCreditCatd(user.creditCard)
        
        let changeDataBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(goToChangeUserData))
        let logoutBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logout))
        
        self.navigationItem.rightBarButtonItem = changeDataBarButtonItem
        self.navigationItem.leftBarButtonItem = logoutBarButtonItem
        
    }
    
    @objc private func goToChangeUserData() {
        
        let controller = UserChangeDataViewController(self)
        self.navigationController?.pushViewController(controller, animated: true)
        
    }
    
    @objc private func logout() {
        
        self.navigationItem.leftBarButtonItem?.isEnabled = false
        personalArea.logout(userId: SessionData.shared.user.id) { response in
            DispatchQueue.main.async {
                self.navigationItem.leftBarButtonItem?.isEnabled = true
                switch response.result {
                case .success(_):
                    let controller = SignInViewController()
                    self.navigationController?.setViewControllers([controller], animated: true)
                    
                case .failure(let error):
                    print(error)
                }
            }
        }
        
    }
}

extension UserProfileViewController: UserProfileViewControllerDelegate {
    
    func updateUserData() {
        
        let user = SessionData.shared.user
        self.navigationItem.title = "\(user.firstName) \(user.surname)"
        self.navigationItem.prompt = user.username
        
        contentView.setGender(user.gender)
        contentView.setCreditCatd(user.creditCard)
        
    }
    
}
