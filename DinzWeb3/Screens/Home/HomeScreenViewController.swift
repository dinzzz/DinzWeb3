//
//  HomeScreenViewController.swift
//  DinzWeb3
//
//  Created by Dino Bozic on 29.02.2024..
//

import Foundation
import UIKit
import Combine

class HomeScreenViewController: UIViewController {
    
    var viewModel: HomeScreenViewModeling
    
    //MARK: - Views
    
    private lazy var contentView: HomeScreenContentView = {
        let view = HomeScreenContentView()
        view.delegate(to: self)
        view.nftsView.delegate(to: self)
        view.nftsView.viewDelegate(to: self)
        return view
    }()
    
    //MARK: - Properties
    
    private var cancellables = Set<AnyCancellable>()

    init(viewModel: HomeScreenViewModeling) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        modalPresentationStyle = .fullScreen
        view.backgroundColor = UIStyle.Color.Background.primary
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.onViewDidAppear()
    }
    
    private func addSubviews() {
        view.addSubview(contentView)
    }
    
    private func setConstraints() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            contentView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant:  -20),
            contentView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func observe() {
        contentView.addressCardView.setup(.init(title: "Wallet Address", subtitle: Web3Service.vitalikEthAddress))
        
        WalletDetailsDatabaseService.shared.fetchPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] cacheModel in
                guard let self else { return }

                self.contentView.nftsView.setup(.init(nfts: Array(cacheModel.nfts.prefix(5))))
                self.contentView.nftCountCardView.setup(.init(title: "NFTs Count", subtitle: "\(cacheModel.nftsCount)"))
                self.contentView.ethBalanceCardView.setup(.init(title: "Account Balance", subtitle: "\(cacheModel.accountBalance) ETH"))
                self.contentView.transactionCountCardView.setup(.init(title: "No. of Transactions", subtitle: "\(cacheModel.transactionsCount)"))
            }.store(in: &cancellables)
        
        
        Publishers.CombineLatest3(viewModel.ethBalance, viewModel.nfts, viewModel.transactionCount)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] balance, nfts, transactionsCount in
                guard let self else { return }
                
                self.contentView.nftsView.setup(.init(nfts: Array(nfts.ownedNfts.prefix(5))))
                self.contentView.nftCountCardView.setup(.init(title: "NFTs Count", subtitle: "\(nfts.totalCount)"))
                
                if let balance = balance.balanceString {
                    self.contentView.ethBalanceCardView.setup(.init(title: "Account Balance", subtitle: "\(balance) ETH"))
                }
                
                if let count = Web3Service.convertToInt(hexValue: transactionsCount) {
                    self.contentView.transactionCountCardView.setup(.init(title: "No. of Transactions", subtitle: "\(count)"))
                }
                
                CacheService().saveToCache(address: Web3Service.vitalikEthAddress,
                                           nftsCount: nfts.totalCount,
                                           transactionsCount: Web3Service.convertToInt(hexValue: transactionsCount) ?? 0,
                                           accBalance: "\(balance.balanceString ?? "0") ETH",
                                           nfts: nfts.ownedNfts)
            }.store(in: &cancellables)
    }
}

extension HomeScreenViewController: HomeScreenNFTRowViewDelegate {
    func didTapNFT(_ nft: Model.NFTModel) {
        viewModel.routeToNFTDetails(nft: nft)
    }
}

extension HomeScreenViewController: HomeScreenNFTsViewDelegate {
    func didTapViewAllNFTs() {
        viewModel.routeToNFTList()
    }
}

extension HomeScreenViewController: HomeScreenContentViewDelegate {
    func didTapIncomingTransactions() {
        viewModel.routeToTransactionList()
    }
}
