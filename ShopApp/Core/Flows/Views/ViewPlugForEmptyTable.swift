//
//  ViewPlugForEmptyTable.swift
//  ShopApp
//
//  Created by Ruslan Safargalin on 19.07.2021.
//

import Foundation
import UIKit

class ViewPlugForEmptyTable: UIView {
    
    // MARK: - Private Variables
    
    private let messageLabel: UILabel
    private let activityIndicator: UIActivityIndicatorView
    
    // MARK: - Enum
    
    enum ActivityIndicatorState {
        case hide,
             show
    }
    
    enum PlugViewState {
        case hide,
             show(activityIndicatorState: ActivityIndicatorState)
    }
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        messageLabel = UILabel()
        activityIndicator = UIActivityIndicatorView(style: .medium)
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    public func setActivityIndicator(state: ActivityIndicatorState) {
        switch state {
        case .show:
            activityIndicator.startAnimating()
            
        case .hide:
            activityIndicator.stopAnimating()
        }
    }
    
    public func setPlugView(state: PlugViewState) {
        switch state {
        case .show(let state):
            isHidden = false
            setActivityIndicator(state: state)
            
        case .hide:
            isHidden = true
            setActivityIndicator(state: .hide)
        }
    }
    
    // MARK: - Private Methods
    
    private func configureUI() {
        
        backgroundColor = .systemBackground
        
        addSubview(messageLabel)
        addSubview(activityIndicator)
        
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        messageLabel.text = "Сейчас здесь пусто..."
        messageLabel.textColor = .lightGray
        messageLabel.font = UIFont.boldSystemFont(ofSize: 17)
        messageLabel.textAlignment = .center
        
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = .accentColor
        
        NSLayoutConstraint.activate([
        
            messageLabel.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor,
                                              constant: layoutMargins.top * 2),
            messageLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            messageLabel.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            messageLabel.heightAnchor.constraint(equalToConstant: 20),
            
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor)
            
        ])
        
    }
    
}
