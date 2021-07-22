//
//  ProductViewController.swift
//  ShopApp
//
//  Created by Ruslan Safargalin on 21.07.2021.
//

import Foundation
import UIKit

class ProductProfileViewController: UIViewController {
    
    // MARK: - Private Variables
    private let reviewsManager: ReviewManager
    private let product: Product
    private var contentView: ProductProfileView {
        return transformView(to: ProductProfileView.self)
    }
    
    // MARK: - Life Cycle
    
    override func loadView() {
        self.view = ProductProfileView(product: product)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        fetchReviewForProduct()
    }
    
    // MARK: - Init
    
    init(product: Product) {
        self.product = product
        let requestFactory = RequestFactory()
        self.reviewsManager = requestFactory.fetchRequestFactory()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func setup() {
        self.navigationItem.title = product.name
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
