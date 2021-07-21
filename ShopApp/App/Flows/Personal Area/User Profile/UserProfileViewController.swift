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
    
    private lazy var router: Router = RouterImpl(for: self)
    private let personalArea: PersonalArea
    private var contentView: UserProfileView {
        return transformView(to: UserProfileView.self)
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
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        updateUserData()
        
        let changeDataBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit,
                                                      target: self,
                                                      action: #selector(goToChangeUserData))
        
        let logoutBarButtonItem = UIBarButtonItem(title: "Logout",
                                                  style: .plain,
                                                  target: self,
                                                  action: #selector(logout))
        
        self.navigationItem.rightBarButtonItem = changeDataBarButtonItem
        self.navigationItem.leftBarButtonItem = logoutBarButtonItem
        
    }
    
    @objc private func goToChangeUserData() {
        router.show(screen: .ChangeData, with: .push, with: false)
    }
    
    @objc private func logout() {
        
        self.navigationItem.leftBarButtonItem?.isEnabled = false
        personalArea.logout(userId: SessionData.shared.user.id) { [weak self] response in
            DispatchQueue.main.async {
                self?.navigationItem.leftBarButtonItem?.isEnabled = true
                switch response.result {
                case .success(_):
                    self?.router.show(screen: .SignIn, with: .present, with: true)
                    
                    
                case .failure(let error):
                    logging(error.localizedDescription)
                }
            }
        }
        
    }
}

extension UserProfileViewController: UserProfileViewControllerDelegate {
    
    func updateUserData() {
        
        let user = SessionData.shared.user
        self.navigationItem.title = user.fullName
        
        contentView.setGender(user.gender)
        contentView.setCreditCatd(user.creditCard)
        
    }
    
}
