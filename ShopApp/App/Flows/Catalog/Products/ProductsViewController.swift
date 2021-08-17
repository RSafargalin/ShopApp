//
//  ProductsViewController.swift
//  ShopApp
//
//  Created by Ruslan Safargalin on 16.07.2021.
//

import Foundation
import UIKit
import FirebaseAnalytics

class ProductsViewController: UIViewController {
    
    // MARK: - Private Variables
    
    private let catalogManager: Catalog
    
    private var contentView: ProductsView {
        return transformView(to: ProductsView.self)
    }
    
    // MARK: - Init
    
    init() {
        let requestFactory = RequestFactory()
        catalogManager = requestFactory.fetchRequestFactory()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle
    
    override func loadView() {
        self.view = ProductsView(parent: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        fetchProducts()
    }
    
    // MARK: - Private methods
    
    private func setup() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Catalog"
    }
    
    private func fetchProducts() {
        contentView.setPlugView(state: .show(activityIndicatorState: .show))
        catalogManager.fetchAll { [weak self] response in
            switch response.result {
            case .success(let result):
                DispatchQueue.main.async {
                    self?.contentView.setPlugView(state: .hide)
                    self?.contentView.update(products: result.response.products)
                }
                Analytics.logEvent("FetchProductsSuccess", parameters: [
                    AnalyticsParameterMethod: self?.method as Any,
                    "username" : SessionData.shared.user.username
                ])
                
            case .failure(let error):
                logging(error.localizedDescription)
                Analytics.logEvent("FetchProductsError", parameters: [
                    AnalyticsParameterMethod: self?.method as Any,
                    "username" : SessionData.shared.user.username
                ])
            }
        }
        
    }
    
}
