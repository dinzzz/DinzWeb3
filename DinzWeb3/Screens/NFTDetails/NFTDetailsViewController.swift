//
//  NFTDetailsViewController.swift
//  DinzWeb3
//
//  Created by Dino Bozic on 02.03.2024..
//

import Foundation
import UIKit
import Combine

class NFTDetailsViewController: UIViewController {
    
    var viewModel: NFTDetailsViewModeling
    
    //MARK: - Views
    
    private lazy var contentView: NFTDetailsContentView = {
        let view = NFTDetailsContentView()
        view.setup(with: viewModel.context.nft)
        return view
    }()
    
    //MARK: - Properties
    
    private var cancellables = Set<AnyCancellable>()

    init(viewModel: NFTDetailsViewModeling) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        modalPresentationStyle = .overFullScreen
        view.backgroundColor = .clear
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setConstraints()
        observe()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIView.animate(withDuration: 0.3, animations: {
            self.contentView.backgroundView.alpha = 1
        })
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIView.animate(withDuration: 0.3, animations: {
            self.contentView.backgroundView.alpha = 0
        })
    }
    
    private func addSubviews() {
        view.addSubview(contentView)
    }
    
    private func setConstraints() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: view.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func observe() {
        contentView.backgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(close)))
    }
    
    @objc func close() {
        dismiss(animated: true)
    }
}
