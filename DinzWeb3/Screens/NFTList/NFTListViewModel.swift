//
//  NFTListViewModel.swift
//  DinzWeb3
//
//  Created by Dino Bozic on 03.03.2024..
//

import Foundation
import Combine

enum NFTListCellType {
    case nft(NFTListItemTableViewCellModel)
}

protocol NFTListViewModeling {
    var context: NFTListContext { get set }
    var dataSource: [NFTListCellType] { get set }
    
    var reloadTablePublisher: AnyPublisher<Bool, Never> { get }
    var errorPublisher: AnyPublisher<Model.ApiError, Never> { get }
    var loadStatus: AnyPublisher<LoadStatus, Never> { get }
    
    func onViewDidLoad()
    func loadNFTs()
    func willDisplay(at index: Int)

    func routeToNFTDetails(nft: Model.NFTModel)
}

final class NFTListViewModel: NFTListViewModeling {
    
    var context: NFTListContext
    private let router: NFTListRouting
    private let web3Service: Web3Servicing
    
    var dataSource: [NFTListCellType] = []
    
    var pageKey: String?
    let countThreshold = 10
    var isLoading = false
    var stopFetch = false
    var isFirstFetch = true
    
    private var reloadTableSubject = PassthroughSubject<Bool, Never>()
    var reloadTablePublisher: AnyPublisher<Bool, Never> {
        return reloadTableSubject.eraseToAnyPublisher()
    }
    
    private var errorSubject = PassthroughSubject<Model.ApiError, Never>()
    var errorPublisher: AnyPublisher<Model.ApiError, Never> {
        return errorSubject.eraseToAnyPublisher()
    }
    
    private var loadStatusSubject = PassthroughSubject<LoadStatus, Never>()
    var loadStatus: AnyPublisher<LoadStatus, Never> {
        loadStatusSubject.eraseToAnyPublisher()
    }

    
    private var cancellables = Set<AnyCancellable>()
    
    init(context: NFTListContext,
         router: NFTListRouting,
         web3Service: Web3Servicing = Web3Service()) {
        self.context = context
        self.router = router
        self.web3Service = web3Service
    }
    
    func onViewDidLoad() {
        observeCache()
        loadCache()
        loadNFTs()
    }
    
    func observeCache() {
        OwnedNFTsDatabaseService.shared.fetchPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] cacheModel in
                guard let self else { return }
                dataSource = cacheModel.nfts.map { NFTListCellType.nft(.init(nft: $0)) }
                reloadTableSubject.send(true)
            }.store(in: &cancellables)
    }
    
    func loadCache() {
        OwnedNFTsDatabaseService.shared.loadOwnedNfts(address: Web3Service.vitalikEthAddress)
    }
    
    func willDisplay(at index: Int) {
        guard !stopFetch else { return }
        guard !isLoading else { return }
        
        if (dataSource.count - index) < countThreshold {
            loadNFTs()
        }
    }
    
    func loadNFTs() {
        isLoading = true
        web3Service.getOwnedNFTs(ownerAddress: Web3Service.vitalikEthAddress, pageKey: pageKey)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self else { return }
                isLoading = false
                switch completion {
                case .finished:
                    break
                case.failure(let error):
                    errorSubject.send(error)
                    router.presentAlert(title: "Failure", message: error.localizedDescription)
                }
            }, receiveValue: { [weak self] response in
                guard let self else { return }
                
                if isFirstFetch {
                    dataSource = []
                    isFirstFetch = false
                }
                
                if response.ownedNfts.isEmpty { self.stopFetch = true }
                response.ownedNfts.forEach { self.dataSource.append(.nft(.init(nft: $0))) }
                let allLoadedNFTs = dataSource.compactMap {
                    switch $0 {
                    case .nft(let model):
                        return model.nft
                    }
                }
                
                CacheService().saveOwnedNftsToCache(address: Web3Service.vitalikEthAddress, nfts: allLoadedNFTs)
                reloadTableSubject.send(true)
                pageKey = response.pageKey
            })
            .store(in: &cancellables)
    }
}

extension NFTListViewModel {
    func routeToNFTDetails(nft: Model.NFTModel) {
        router.presentNFTDetails(nft: nft)
    }
}
