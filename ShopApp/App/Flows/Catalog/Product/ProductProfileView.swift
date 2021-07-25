//
//  ProductView.swift
//  ShopApp
//
//  Created by Ruslan Safargalin on 21.07.2021.
//

import Foundation
import UIKit

class ProductProfileView: UIView, ContentView {
    
    // MARK: - Public Variables
    
    let scrollView: UIScrollView
    
    // MARK: - Private Variables
    
    private let validationManager: ValidationManager
    private let reviewsManager: ReviewManager
    private var reviews = [Review]()
    private let parent: ProductProfileViewControllerProtocol?
    
    private let reviewsLabel: UILabel
    private let reviewsCollection: UICollectionView
    
    private let productInfoLabel: UILabel
    private let productPriceLabel: UILabel
    private let productPriceIcon: UIImageView
    
    private let viewPlugForEmptyReviews: ViewPlugForEmptyTable = ViewPlugForEmptyTable()
    
    private let addProductToCartLabel: UILabel
    private let productCountField: UITextField
    let addProductToCartButton: UIButton
    
    private var productQuantity: Int
    
    // MARK: - Init
    
    required init(parent: ProductProfileViewControllerProtocol) {
        self.scrollView = UIScrollView()
        let requestFactory = RequestFactory()
        self.reviewsManager = requestFactory.fetchRequestFactory()
        self.validationManager = ValidationManager()
        self.reviewsLabel = UILabel()
        self.reviewsCollection = UICollectionView(frame: CGRect(), collectionViewLayout: UICollectionViewLayout())
        self.productInfoLabel = UILabel()
        self.productPriceLabel = UILabel()
        self.productPriceIcon = UIImageView(image: UIImage(systemName: "rublesign.square"))
        self.addProductToCartLabel = UILabel()
        self.productCountField = UITextField()
        self.addProductToCartButton = UIButton()
        self.parent = parent
        self.productQuantity = 0
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
        addProductToCartButton.set(.disabled)
        productCountField.delegate = self
        
        configureUI()
        
    }
    
    private func configureUI() {
        
        backgroundColor = .systemBackground
        reviewsCollection.backgroundColor = .systemBackground
        
        addSubview(scrollView)
        
        scrollView.addSubview(productInfoLabel)
        scrollView.addSubview(productPriceIcon)
        scrollView.addSubview(productPriceLabel)
        
        scrollView.addSubview(reviewsLabel)
        scrollView.addSubview(reviewsCollection)
        
        scrollView.addSubview(viewPlugForEmptyReviews)
        
        scrollView.addSubview(addProductToCartLabel)
        scrollView.addSubview(productCountField)
        scrollView.addSubview(addProductToCartButton)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        viewPlugForEmptyReviews.translatesAutoresizingMaskIntoConstraints = false
        productInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        productPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        productPriceIcon.translatesAutoresizingMaskIntoConstraints = false
        reviewsLabel.translatesAutoresizingMaskIntoConstraints = false
        reviewsCollection.translatesAutoresizingMaskIntoConstraints = false
        addProductToCartLabel.translatesAutoresizingMaskIntoConstraints = false
        productCountField.translatesAutoresizingMaskIntoConstraints = false
        addProductToCartButton.translatesAutoresizingMaskIntoConstraints = false
        
        productCountField.keyboardType = .numberPad
        productCountField.borderStyle = .roundedRect
        productCountField.placeholder = "Quantity of goods..."
        productCountField.addTarget(self, action: #selector(textFieldChangeValue), for: .allEditingEvents)
        productCountField.isUserInteractionEnabled = true
        
        addProductToCartButton.setImage(UIImage(systemName: "cart.fill.badge.plus"), for: .normal)
        addProductToCartButton.backgroundColor = .accentColor
        addProductToCartButton.tintColor = .white
        addProductToCartButton.layer.cornerRadius = 10
        addProductToCartButton.addTarget(self, action: #selector(addToCart), for: .touchUpInside)
        
        productInfoLabel.text = "Detail info"
        productInfoLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        
        reviewsLabel.text = "Reviews"
        reviewsLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        
        addProductToCartLabel.text = "Add to cart..."
        addProductToCartLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        
        reviewsCollection.collectionViewLayout = createCollectionViewLayout()
        reviewsCollection.showsHorizontalScrollIndicator = false
        reviewsCollection.showsVerticalScrollIndicator = false
        reviewsCollection.isPagingEnabled = true
        
        NSLayoutConstraint.activate([
            
            scrollView.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
//            scrollView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            
//            productInfoLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
//            productPriceIcon.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
//            productPriceLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
//            reviewsLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            reviewsCollection.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
//            viewPlugForEmptyReviews.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
//            addProductToCartLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
//            addProductToCartButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
//            productCountField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            
            productInfoLabel.topAnchor.constraint(equalTo: scrollView.topAnchor,
                                                 constant: scrollView.layoutMargins.top * 4),
            productInfoLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,
                                                      constant: scrollView.layoutMargins.left * 2),
            productInfoLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor,
                                                       constant: scrollView.layoutMargins.left * 2),
            
            productPriceIcon.topAnchor.constraint(equalTo: productInfoLabel.layoutMarginsGuide.bottomAnchor,
                                                constant: productInfoLabel.layoutMargins.top * 2),
            productPriceIcon.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,
                                                      constant: scrollView.layoutMargins.left * 2),
            productPriceIcon.trailingAnchor.constraint(greaterThanOrEqualTo: productPriceLabel.leadingAnchor,
                                                       constant: -productPriceLabel.layoutMargins.left * 2),
            productPriceIcon.widthAnchor.constraint(equalToConstant: 24),
            productPriceIcon.heightAnchor.constraint(equalToConstant: 24),
            
            productPriceLabel.centerYAnchor.constraint(equalTo: productPriceIcon.centerYAnchor),
            productPriceLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor,
                                                        constant: scrollView.layoutMargins.left * 2),
            productPriceLabel.heightAnchor.constraint(equalToConstant: Constant.Sizes.Label.rawValue),
            
            reviewsLabel.topAnchor.constraint(equalTo: productPriceLabel.bottomAnchor,
                                                   constant: productPriceLabel.layoutMargins.bottom * 2),
            reviewsLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,
                                                  constant: scrollView.layoutMargins.left * 2),
            reviewsLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor,
                                                   constant: scrollView.layoutMargins.left * 2),
            
            reviewsCollection.topAnchor.constraint(equalTo: reviewsLabel.bottomAnchor),
            reviewsCollection.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            reviewsCollection.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            reviewsCollection.heightAnchor.constraint(equalToConstant: 230),
            
            viewPlugForEmptyReviews.topAnchor.constraint(equalTo: reviewsLabel.bottomAnchor),
            viewPlugForEmptyReviews.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            viewPlugForEmptyReviews.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            viewPlugForEmptyReviews.heightAnchor.constraint(equalToConstant: 230),
            
            addProductToCartLabel.topAnchor.constraint(equalTo: reviewsCollection.bottomAnchor,
                                                   constant: reviewsCollection.layoutMargins.bottom * 2),
            addProductToCartLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,
                                                           constant: scrollView.layoutMargins.left * 2),
            addProductToCartLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor,
                                                            constant: scrollView.layoutMargins.left * 2),
            
            productCountField.topAnchor.constraint(equalTo: addProductToCartLabel.bottomAnchor,
                                                   constant: addProductToCartLabel.layoutMargins.bottom * 2),
            productCountField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,
                                                       constant: scrollView.layoutMargins.left * 2),
            productCountField.trailingAnchor.constraint(equalTo: addProductToCartButton.layoutMarginsGuide.leadingAnchor,
                                                        constant: -addProductToCartButton.layoutMargins.left * 2),
            productCountField.heightAnchor.constraint(equalToConstant: 44),
//            productCountField.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor,
//                                                      constant: -scrollView.layoutMargins.bottom * 4),
            
            addProductToCartButton.centerYAnchor.constraint(equalTo: productCountField.centerYAnchor),
            addProductToCartButton.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor,
                                                             constant: -scrollView.layoutMargins.left * 2),
            addProductToCartButton.widthAnchor.constraint(equalToConstant: 88),
            addProductToCartButton.heightAnchor.constraint(equalToConstant: 44),
            addProductToCartButton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor,
                                                           constant: -scrollView.layoutMargins.bottom * 2)
            
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
    
    @objc private func addToCart() {
        guard let controller = parent,
              productQuantity > 0 else { return }
        controller.addProductToCart(in: productQuantity)
    }
    
    @objc private func textFieldChangeValue() {
        guard let text = productCountField.text,
              validationManager.isValid(value: text, for: .IntAndNotZero),
              let quantity = Int(text)
        else {
            addProductToCartButton.set(.disabled)
            return
        }
        addProductToCartButton.set(.enabled)
        productQuantity = quantity
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

extension ProductProfileView: UITextFieldDelegate {

    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if let text = textField.text, let textRange = Range(range, in: text) {
            
            let updatedText = text.replacingCharacters(in: textRange, with: string)
            if updatedText.isEmpty { return true }
            return validationManager.isValid(value: updatedText, for: .IntAndNotZero)
            
        }
        return true
        
    }

}
