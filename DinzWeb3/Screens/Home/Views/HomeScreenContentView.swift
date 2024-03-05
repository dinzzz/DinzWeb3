//
//  HomeScreenContentView.swift
//  DinzWeb3
//
//  Created by Dino Bozic on 01.03.2024..
//

import Foundation
import UIKit

protocol HomeScreenContentViewDelegate: AnyObject {
    func didTapIncomingTransactions()
}

class HomeScreenContentView: UIView {
    
    weak var delegate: HomeScreenContentViewDelegate?
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIStyle.Font.Headline.big
        label.textColor = UIStyle.Color.Basic.primary
        label.numberOfLines = 0
        label.text = "Dinz Web3 Wallet"
        return label
    }()
    
    lazy var addressCardView = HomeScreenCardView()
    
    private lazy var topStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.spacing = 24
        return stackView
    }()
    lazy var nftCountCardView = HomeScreenCardView()
    lazy var transactionCountCardView = HomeScreenCardView()
    lazy var ethBalanceCardView = HomeScreenCardView()
    
    lazy var incomingTransactionsButton: UIButton = {
        let button = UIButton()
        button.setTitle("View Incoming Transactions", for: .normal)
        button.setTitleColor(UIStyle.Color.Basic.primary, for: .normal)
        button.titleLabel?.textAlignment = .center
        return button
    }()
    
    lazy var nftsView = HomeScreenNFTsView()
    
    init() {
        super.init(frame: .zero)
        
        addSubviews()
        setConstraints()
        observe()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func addSubviews() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(addressCardView)
        
        contentView.addSubview(topStackView)
        topStackView.addArrangedSubview(nftCountCardView)
        topStackView.addArrangedSubview(transactionCountCardView)
        topStackView.addArrangedSubview(ethBalanceCardView)
        
        contentView.addSubview(incomingTransactionsButton)
        
        contentView.addSubview(nftsView)
    }
    
    private func setConstraints() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addressCardView.translatesAutoresizingMaskIntoConstraints = false
        topStackView.translatesAutoresizingMaskIntoConstraints = false
        incomingTransactionsButton.translatesAutoresizingMaskIntoConstraints = false
        nftsView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            addressCardView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            addressCardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            addressCardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            topStackView.topAnchor.constraint(equalTo: addressCardView.bottomAnchor, constant: 24),
            topStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            topStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            incomingTransactionsButton.topAnchor.constraint(equalTo: topStackView.bottomAnchor, constant: 24),
            incomingTransactionsButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            incomingTransactionsButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            nftsView.topAnchor.constraint(equalTo: incomingTransactionsButton.bottomAnchor, constant: 24),
            nftsView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            nftsView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            nftsView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
        ])
    }
    
    private func observe() {
        incomingTransactionsButton.addAction(UIAction(handler: { [weak self] _ in
            self?.delegate?.didTapIncomingTransactions()
        }), for: .touchUpInside)
    }
    
    
    func delegate(to delegate: HomeScreenContentViewDelegate) {
        self.delegate = delegate
    }
}
