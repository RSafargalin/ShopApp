//
//  ProductView.swift
//  ShopApp
//
//  Created by Ruslan Safargalin on 21.07.2021.
//

import Foundation
import UIKit

class ProductProfileView: UIView {
    
    // MARK: - Private Variables
    
    private let reviewsManager: ReviewManager
    private var reviews = [Review]()
    private let product: Product
    
    private let reviewsLabel: UILabel
    private let reviewsCollection: UICollectionView
    
    private let productInfoLabel: UILabel
    private let productPriceLabel: UILabel
    private let productPriceIcon: UIImageView
    
    private let viewPlugForEmptyReviews: ViewPlugForEmptyTable = ViewPlugForEmptyTable()
    
    
    // MARK: - Init
    
    required init(product: Product) {
        let requestFactory = RequestFactory()
        self.reviewsManager = requestFactory.fetchRequestFactory()
        self.reviewsLabel = UILabel()
        self.reviewsCollection = UICollectionView(frame: CGRect(), collectionViewLayout: UICollectionViewLayout())
        self.productInfoLabel = UILabel()
        self.productPriceLabel = UILabel()
        self.productPriceIcon = UIImageView(image: UIImage(systemName: "rublesign.square"))
        self.product = product
        super.init(frame: CGRect())
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    public func setPrice(from product: Product) {
        productPriceLabel.text = product.getPriceInStringFormat()
    }
    
    public func update(reviews: [Review]) {
        DispatchQueue.main.async {
            self.reviews = reviews
            self.reviewsCollection.reloadData()
        }
    }
    
    public func setPlugView(state: ViewPlugForEmptyTable.PlugViewState) {
        DispatchQueue.main.async {
            switch state {
            case .show(let state):
                self.viewPlugForEmptyReviews.setPlugView(state: .show(activityIndicatorState: state))
                
            case .hide:
                self.viewPlugForEmptyReviews.setPlugView(state: state)
            }
        }
    }
    
    // MARK: - Private Methods
 
    private func setup() {
        
        reviewsCollection.delegate = self
        reviewsCollection.dataSource = self
        reviewsCollection.register(ReviewCell.self, forCellWithReuseIdentifier: ReviewCell.identifier)
        productPriceLabel.text = product.getPriceInStringFormat()
        
        configureUI()
        
    }
    
    private func configureUI() {
        
        backgroundColor = .systemBackground
        reviewsCollection.backgroundColor = .systemBackground
        
        addSubview(productInfoLabel)
        addSubview(productPriceIcon)
        addSubview(productPriceLabel)
        addSubview(reviewsLabel)
        addSubview(reviewsCollection)
        addSubview(viewPlugForEmptyReviews)
        
        viewPlugForEmptyReviews.translatesAutoresizingMaskIntoConstraints = false
        productInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        productPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        productPriceIcon.translatesAutoresizingMaskIntoConstraints = false
        reviewsLabel.translatesAutoresizingMaskIntoConstraints = false
        reviewsCollection.translatesAutoresizingMaskIntoConstraints = false
        
        productInfoLabel.text = "Detail info"
        productInfoLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        
        reviewsLabel.text = "Reviews"
        reviewsLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        
        reviewsCollection.collectionViewLayout = createCollectionViewLayout()
        reviewsCollection.showsHorizontalScrollIndicator = false
        reviewsCollection.showsVerticalScrollIndicator = false
        reviewsCollection.isPagingEnabled = true
        
        NSLayoutConstraint.activate([
            
            productInfoLabel.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor,
                                                 constant: self.layoutMargins.top * 2),
            productInfoLabel.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            productInfoLabel.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor),
            
            productPriceIcon.topAnchor.constraint(equalTo: productInfoLabel.layoutMarginsGuide.bottomAnchor,
                                                constant: productInfoLabel.layoutMargins.top * 2),
            productPriceIcon.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            productPriceIcon.trailingAnchor.constraint(greaterThanOrEqualTo: productPriceLabel.leadingAnchor,
                                                       constant: -productPriceLabel.layoutMargins.left * 2),
            productPriceIcon.widthAnchor.constraint(equalToConstant: 24),
            productPriceIcon.heightAnchor.constraint(equalToConstant: 24),
            
            productPriceLabel.centerYAnchor.constraint(equalTo: productPriceIcon.centerYAnchor),
            productPriceLabel.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor),
            productPriceLabel.heightAnchor.constraint(equalToConstant: Constant.Sizes.Label.rawValue),
            
            reviewsLabel.topAnchor.constraint(equalTo: productPriceLabel.bottomAnchor,
                                                   constant: productPriceLabel.layoutMargins.bottom * 2),
            reviewsLabel.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            reviewsLabel.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor),
            
            reviewsCollection.topAnchor.constraint(equalTo: reviewsLabel.bottomAnchor),
            reviewsCollection.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            reviewsCollection.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            reviewsCollection.heightAnchor.constraint(equalToConstant: 230),
            
            viewPlugForEmptyReviews.topAnchor.constraint(equalTo: reviewsLabel.bottomAnchor),
            viewPlugForEmptyReviews.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            viewPlugForEmptyReviews.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            viewPlugForEmptyReviews.heightAnchor.constraint(equalToConstant: 230),
            
        ])
        
    }
    
    private func createCollectionViewLayout() -> UICollectionViewFlowLayout {
        
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewFlowLayout.sectionInset = UIEdgeInsets(top: layoutMargins.top,
                                                         left: layoutMargins.left * 2,
                                                         bottom: layoutMargins.bottom,
                                                         right: layoutMargins.right * 2)
        
        collectionViewFlowLayout.itemSize = CGSize(width: (UIScreen.main.bounds.width - (self.layoutMargins.left * 4)),
                                                   height: 200)
    
        collectionViewFlowLayout.scrollDirection = .horizontal
        collectionViewFlowLayout.minimumLineSpacing = self.layoutMargins.left * 4
        
        return collectionViewFlowLayout
        
    }
    
}

// MARK: - ProductProfileView + UICollectionViewDelegate, ProductProfileView + UICollectionViewDataSource

extension ProductProfileView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        reviews.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let review = reviews[indexPath.item]
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReviewCell.identifier,
                                                         for: indexPath) as? ReviewCell {
            cell.configure(from: review)
            return cell
            
        } else {
            
            let cell = ReviewCell()
            cell.configure(from: review)
            return cell
            
        }
        
    }
    
}
