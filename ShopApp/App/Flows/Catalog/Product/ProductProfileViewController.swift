//
//  ProductViewController.swift
//  ShopApp
//
//  Created by Ruslan Safargalin on 21.07.2021.
//

import Foundation
import UIKit
import FirebaseAnalytics

protocol ProductProfileViewControllerProtocol {

    func addProductToCart(in quantity: Int)
    
}

class ProductProfileViewController: UITextFieldsViewController {
    
    // MARK: - Private Variables
    private let reviewsManager: ReviewManager
    private let cartManager: CartManager
    private let product: Product
    private var contentView: ProductProfileView {
        return transformView(to: ProductProfileView.self)
    }
    
    // MARK: - Life Cycle
    
    override func loadView() {
        self.view = ProductProfileView(parent: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        fetchReviewForProduct()
        contentView.setPrice(from: product)
        Analytics.logEvent("ProductProfile", parameters: [
            AnalyticsParameterMethod: self.method as Any,
            "username" : SessionData.shared.user.username,
            "productId" : product.id
        ])
    }
    
    // MARK: - Init
    
    init(product: Product) {
        self.product = product
        let requestFactory = RequestFactory()
        self.reviewsManager = requestFactory.fetchRequestFactory()
        self.cartManager = requestFactory.fetchRequestFactory()
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    override func setup() {
        self.navigationItem.title = product.name
        super.setup()
    }
    
    private func fetchReviewForProduct() {
        contentView.setPlugView(state: .show(activityIndicatorState: .show))
        reviewsManager.fetchAllReviews(for: product.id) { [weak self] response in
            switch response.result {
            case .success(let result):
                DispatchQueue.main.async {
                    if result.response.reviews.count > 0 {
                        self?.contentView.setPlugView(state: .hide)
                    } else {
                        self?.contentView.setPlugView(state: .show(activityIndicatorState: .hide))
                    }
                    self?.contentView.update(reviews: result.response.reviews)
                }
                
            case .failure(let error):
                logging(error.localizedDescription)
            }
        }
    }
}

extension ProductProfileViewController: ProductProfileViewControllerProtocol {
    
    func addProductToCart(in quantity: Int) {
        DispatchQueue.main.async {
            self.contentView.addProductToCartButton.set(.disabled)
        }
        cartManager.add(productId: product.id, with: quantity) { [weak self] response in
            DispatchQueue.main.async {
                self?.contentView.addProductToCartButton.set(.enabled, sleep: 1)
            }
            switch response.result {
            case .success(_):
                Analytics.logEvent(AnalyticsEventAddToCart, parameters: [
                    AnalyticsParameterMethod: self?.method as Any,
                    "username" : SessionData.shared.user.username,
                    "productId" : self?.product.id ?? -1
                ])
                break
                
            case .failure(let error):
                logging(error.localizedDescription)
            }
        }
        
    }
    
}
