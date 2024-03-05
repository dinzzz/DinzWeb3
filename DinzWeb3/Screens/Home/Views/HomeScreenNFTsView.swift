//
//  HomeScreenNFTsView.swift
//  DinzWeb3
//
//  Created by Dino Bozic on 01.03.2024..
//

import Foundation
import UIKit

struct HomeScreenNFTsViewModel {
    var nfts: [Model.NFTModel]
}

protocol HomeScreenNFTsViewDelegate: AnyObject {
    func didTapViewAllNFTs()
}

class HomeScreenNFTsView: UIView {
    
    weak var delegate: HomeScreenNFTsViewDelegate?
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIStyle.Font.Body.regular
        label.textColor = UIStyle.Color.Basic.primary
        label.textAlignment = .center
        label.text = "NFTs"
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing  = 10
        stackView.axis = .vertical
        return stackView
    }()
    
    lazy var nft1View = HomeScreenNFTRowView()
    lazy var nft2View = HomeScreenNFTRowView()
    lazy var nft3View = HomeScreenNFTRowView()
    lazy var nft4View = HomeScreenNFTRowView()
    lazy var nft5View = HomeScreenNFTRowView()
    
    private lazy var viewAllButton: UIButton = {
        let button = UIButton()
        button.setTitle("View All", for: .normal)
        return button
    }()
    
    init() {
        super.init(frame: .zero)
        
        setupView()
        addSubviews()
        setConstraints()
        observe()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setupView() {
        backgroundColor = UIStyle.Color.Background.cards
        layer.cornerRadius = 20
        layer.cornerCurve = .continuous
    }
    
    private func addSubviews() {
        addSubview(titleLabel)
        addSubview(stackView)
        stackView.addArrangedSubview(nft1View)
        stackView.addArrangedSubview(nft2View)
        stackView.addArrangedSubview(nft3View)
        stackView.addArrangedSubview(nft4View)
        stackView.addArrangedSubview(nft5View)
        addSubview(viewAllButton)
    }
    
    private func setConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        viewAllButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            
            viewAllButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 12),
            viewAllButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            viewAllButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            viewAllButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)
        ])
    }
    
    private func observe() {
        viewAllButton.addAction(UIAction(handler: { [weak self] _ in
            self?.delegate?.didTapViewAllNFTs()
        }), for: .touchUpInside)
    }
    
    func setup(_ viewModel: HomeScreenNFTsViewModel) {
        let views = [nft1View, nft2View, nft3View, nft4View, nft5View]
        viewModel.nfts.enumerated().forEach {
            views[$0.offset].setup(.init(nft: $0.element))
        }
    }
    
    func delegate(to delegate: HomeScreenNFTRowViewDelegate) {
        let views = [nft1View, nft2View, nft3View, nft4View, nft5View]
        views.forEach {
            $0.delegate = delegate
        }
    }
    
    func viewDelegate(to delegate: HomeScreenNFTsViewDelegate) {
        self.delegate = delegate
    }
}
