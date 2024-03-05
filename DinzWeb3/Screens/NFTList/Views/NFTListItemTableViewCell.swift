//
//  NFTListItemTableViewCell.swift
//  DinzWeb3
//
//  Created by Dino Bozic on 03.03.2024..
//

import Foundation
import UIKit

struct NFTListItemTableViewCellModel {
    var nft: Model.NFTModel
}

class NFTListItemTableViewCell: UITableViewCell {
    
    // MARK: - Views
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 20
        view.layer.cornerCurve = .continuous
        view.backgroundColor = UIStyle.Color.Background.cards
        return view
    }()
    
    lazy var thumbnailImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 20
        return image
    }()

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIStyle.Color.Basic.primary
        label.font = UIStyle.Font.Body.regular
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5

        return label
    }()

    lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIStyle.Color.Basic.primary
        label.font = UIStyle.Font.Body.small
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5

        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupView()
        addSubviews()
        setConstraints()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        selectionStyle = .none
        backgroundColor = .clear
    }

    private func addSubviews() {
        contentView.addSubview(containerView)
        containerView.addSubview(thumbnailImageView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(subtitleLabel)
    }

    private func setConstraints() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        thumbnailImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
    
        
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),

            thumbnailImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            thumbnailImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20),
            thumbnailImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            thumbnailImageView.heightAnchor.constraint(equalToConstant: 40),
            thumbnailImageView.widthAnchor.constraint(equalToConstant: 40),
            
            titleLabel.leadingAnchor.constraint(equalTo: thumbnailImageView.trailingAnchor, constant: 8),
            titleLabel.bottomAnchor.constraint(equalTo: containerView.centerYAnchor, constant: -4),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            
            subtitleLabel.leadingAnchor.constraint(equalTo: thumbnailImageView.trailingAnchor, constant: 8),
            subtitleLabel.topAnchor.constraint(equalTo: containerView.centerYAnchor, constant: 4),
            subtitleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
        ])
    }
    
    func setup(_ viewModel: NFTListItemTableViewCellModel) {
        thumbnailImageView.kf.setImage(with: viewModel.nft.nftImageUrl?.toURL())
        titleLabel.text = viewModel.nft.contract.name
        subtitleLabel.text = viewModel.nft.contract.address
    }
}
