//
//  HomeScreenNFTRowView.swift
//  DinzWeb3
//
//  Created by Dino Bozic on 02.03.2024..
//

import Foundation
import UIKit
import Kingfisher
import Combine

struct HomeScreenNFTRowViewModel {
    var nft: Model.NFTModel
}

protocol HomeScreenNFTRowViewDelegate: AnyObject {
    func didTapNFT(_ nft: Model.NFTModel)
}

class HomeScreenNFTRowView: UIButton {
    
    var nftModel: Model.NFTModel?
    
    weak var delegate: HomeScreenNFTRowViewDelegate?
    
    private lazy var nftImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 20
        imageView.backgroundColor = .white
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var nftTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIStyle.Font.Body.small
        label.textColor = UIStyle.Color.Basic.primary
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
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
        backgroundColor = UIStyle.Color.Background.rows
        layer.cornerRadius = 20
        layer.cornerCurve = .continuous
    }
    
    private func addSubviews() {
        addSubview(nftImageView)
        addSubview(nftTitleLabel)
    }
    
    private func setConstraints() {
        nftImageView.translatesAutoresizingMaskIntoConstraints = false
        nftTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nftImageView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            nftImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            nftImageView.heightAnchor.constraint(equalToConstant: 40),
            nftImageView.widthAnchor.constraint(equalToConstant: 40),
            nftImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            
            nftTitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            nftTitleLabel.leadingAnchor.constraint(equalTo: nftImageView.trailingAnchor, constant: 8),
            nftTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            nftTitleLabel.centerYAnchor.constraint(equalTo: nftImageView.centerYAnchor)
        ])
    }
    
    private func observe() {
        addAction(UIAction(handler: { [weak self] _ in
            guard let nft = self?.nftModel else { return }
            self?.delegate?.didTapNFT(nft)
        }), for: .touchUpInside)
    }
    
    func setup(_ viewModel: HomeScreenNFTRowViewModel) {
        nftModel = viewModel.nft
        nftImageView.kf.setImage(with: viewModel.nft.nftImageUrl?.toURL())
        nftTitleLabel.text = viewModel.nft.contract.address
    }
}

extension String {
    func toURL() -> URL? {
        URL(string: self)
    }
}
