//
//  HomeScreenViewModel.swift
//  DinzWeb3
//
//  Created by Dino Bozic on 29.02.2024..
//

import Foundation
import Combine

protocol HomeScreenViewModeling {
    var context: HomeScreenContext { get set }
    
    var ethBalance: AnyPublisher<Model.ETHBalanceModel, Never> { get }
    var nfts: AnyPublisher<Model.GetNFTsForOwnerResponse, Never> { get }
    var tokenBalances: AnyPublisher<[Model.TokenBalance], Never> { get }
    var transactionCount: AnyPublisher<String, Never> { get }
    var errorPublisher: AnyPublisher<Model.ApiError, Never> { get }
    var loadStatus: AnyPublisher<LoadStatus, Never> { get }
    
    func routeToNFTDetails(nft: Model.NFTModel)
    func routeToNFTList()
    func routeToTransactionList()
    
    func onViewDidAppear()
    func getCache()
    
    func fetchETHBalance()
    func fetchWalletNFTs()
    func fetchTokenBalances()
    func fetchTransactionCount()
}

final class HomeScreenViewModel: HomeScreenViewModeling {
    
    var context: HomeScreenContext
    
    private let router: HomeScreenRouting
    private let web3Service: Web3Servicing
    
    private var cancellables = Set<AnyCancellable>()
    
    private var ethBalanceSubject = PassthroughSubject<Model.ETHBalanceModel, Never>()
    private var nftsSubject = PassthroughSubject<Model.GetNFTsForOwnerResponse, Never>()
    private var tokenBalancesSubject = PassthroughSubject<[Model.TokenBalance], Never>()
    private var transactionCountSubject = PassthroughSubject<String, Never>()
    private var errorSubject = PassthroughSubject<Model.ApiError, Never>()
    private var loadStatusSubject = PassthroughSubject<LoadStatus, Never>()
    
    init(context: HomeScreenContext,
         router: HomeScreenRouting,
         web3Service: Web3Servicing = Web3Service()) {
        self.context = context
        self.router = router
        self.web3Service = web3Service
    }
    
    func onViewDidAppear() {
        getCache()
        
        fetchETHBalance()
        fetchWalletNFTs()
        fetchTokenBalances()
        fetchTransactionCount()
    }
    
    func getCache() {
        WalletDetailsDatabaseService.shared.loadWalletDetails(address: Web3Service.vitalikEthAddress)
    }
    
    func fetchETHBalance() {
        loadStatusSubject.send(.loading)
        web3Service.getETHBalance(address: Web3Service.vitalikEthAddress)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self else { return }
                switch completion {
                case .finished:
                    loadStatusSubject.send(.none)
                case.failure(let error):
                    errorSubject.send(error)
                    loadStatusSubject.send(.error(error))
                    router.presentAlert(title: "Failure", message: error.localizedDescription)
                }
            }, receiveValue: { [weak self] response in
                guard let self else { return }
                ethBalanceSubject.send(response)
            })
            .store(in: &cancellables)
    }
    
    func fetchWalletNFTs() {
        loadStatusSubject.send(.loading)
        web3Service.getOwnedNFTs(ownerAddress: Web3Service.vitalikEthAddress, pageKey: nil)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self else { return }
                switch completion {
                case .finished:
                    loadStatusSubject.send(.none)
                case.failure(let error):
                    errorSubject.send(error)
                    loadStatusSubject.send(.error(error))
                    router.presentAlert(title: "Failure", message: error.localizedDescription)
                }
            }, receiveValue: { [weak self] response in
                guard let self else { return }
                nftsSubject.send(response)
            })
            .store(in: &cancellables)
    }
    
    func fetchTokenBalances() {
        loadStatusSubject.send(.loading)
        web3Service.getTokenBalances(address: Web3Service.vitalikEthAddress)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self else { return }
                switch completion {
                case .finished:
                    loadStatusSubject.send(.none)
                case.failure(let error):
                    errorSubject.send(error)
                    loadStatusSubject.send(.error(error))
                    router.presentAlert(title: "Failure", message: error.localizedDescription)
                }
            }, receiveValue: { [weak self] response in
                guard let self else { return }
                tokenBalancesSubject.send(response)
            })
            .store(in: &cancellables)
    }
    
    func fetchTransactionCount() {
        loadStatusSubject.send(.loading)
        web3Service.getTransactionCount(address: Web3Service.vitalikEthAddress)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self else { return }
                switch completion {
                case .finished:
                    loadStatusSubject.send(.none)
                case.failure(let error):
                    errorSubject.send(error)
                    loadStatusSubject.send(.error(error))
                    router.presentAlert(title: "Failure", message: error.localizedDescription)
                }
            }, receiveValue: { [weak self] response in
                guard let self else { return }
                transactionCountSubject.send(response)
            })
            .store(in: &cancellables)
    }
}

// MARK: - Routing

extension HomeScreenViewModel {
    func routeToNFTDetails(nft: Model.NFTModel) {
        router.presentNFTDetails(nft: nft)
    }
    
    func routeToNFTList() {
        router.presentNFTList()
    }
    
    func routeToTransactionList() {
        router.presentTransactionList()
    }
}

//MARK: - Publishers

extension HomeScreenViewModel {
    
    var ethBalance: AnyPublisher<Model.ETHBalanceModel, Never> {
        return ethBalanceSubject.eraseToAnyPublisher()
    }

    var nfts: AnyPublisher<Model.GetNFTsForOwnerResponse, Never> {
        return nftsSubject.eraseToAnyPublisher()
    }
    
    var tokenBalances: AnyPublisher<[Model.TokenBalance], Never> {
        return tokenBalancesSubject.eraseToAnyPublisher()
    }
    
    var transactionCount: AnyPublisher<String, Never> {
        return transactionCountSubject.eraseToAnyPublisher()
    }
    
    var errorPublisher: AnyPublisher<Model.ApiError, Never> {
        return errorSubject.eraseToAnyPublisher()
    }
    
    var loadStatus: AnyPublisher<LoadStatus, Never> {
        loadStatusSubject.eraseToAnyPublisher()
    }
}
