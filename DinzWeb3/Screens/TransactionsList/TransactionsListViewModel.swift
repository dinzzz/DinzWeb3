//
//  TransactionsListViewModel.swift
//  DinzWeb3
//
//  Created by Dino Bozic on 03.03.2024..
//

import Foundation
import Combine

protocol TransactionsListViewModeling: ObservableObject {
    var context: TransactionsListContext { get set }
    
    var transfers: [Model.AssetTransferModel] { get }
    
    func onViewDidLoad()
    func willDisplay(at index: Int)
    
    func routeToDetails(model: Model.AssetTransferModel)
    
    var errorPublisher: AnyPublisher<Model.ApiError, Never> { get }
    var loadStatus: AnyPublisher<LoadStatus, Never> { get }
}

final class TransactionsListViewModel: TransactionsListViewModeling {
    var context: TransactionsListContext
    private let router: any TransactionsListRouting
    private let web3Service: Web3Servicing
    
    @Published var transfers: [Model.AssetTransferModel] = []
    @Published var isUILoading = false
    
    var pageKey: String?
    let countThreshold = 10
    var isLoading = false
    var stopFetch = false
    var isFirstFetch = true
    
    private var errorSubject = PassthroughSubject<Model.ApiError, Never>()
    var errorPublisher: AnyPublisher<Model.ApiError, Never> {
        return errorSubject.eraseToAnyPublisher()
    }
    
    private var loadStatusSubject = PassthroughSubject<LoadStatus, Never>()
    var loadStatus: AnyPublisher<LoadStatus, Never> {
        loadStatusSubject.eraseToAnyPublisher()
    }
    
    private var cancellables = Set<AnyCancellable>()
    
    init(context: TransactionsListContext,
         router: any TransactionsListRouting,
         web3Service: Web3Servicing = Web3Service()) {
        self.context = context
        self.router = router
        self.web3Service = web3Service
    }
    
    func onViewDidLoad() {
        bind()
        observeCache()
        
        loadCache()
        loadTransactions()
    }
    
    func bind() {
        loadStatusSubject
            .map {  status in
                return status == .loading
            }
            .assign(to: &$isUILoading)
    }
    
    func observeCache() {
        IncomingTransactionsDatabaseService.shared.fetchPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] cacheModel in
                guard let self else { return }
                self.transfers = cacheModel.transactions
            }.store(in: &cancellables)
    }
    
    func willDisplay(at index: Int) {
        guard !stopFetch else { return }
        guard !isLoading else { return }
        
        if (transfers.count - index) < countThreshold {
            loadTransactions()
        }
    }
    
    func loadCache() {
        IncomingTransactionsDatabaseService.shared.loadIncomingTransactions(address: Web3Service.vitalikEthAddress)
    }
    
    func loadTransactions() {
        loadStatusSubject.send(.loading)
        isLoading = true
        web3Service.getToAssetTransfers(address: Web3Service.vitalikEthAddress, pageKey: pageKey)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self else { return }
                isLoading = false
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
                
                if isFirstFetch {
                    transfers = []
                    isFirstFetch = false
                }
                
                if response.transfers.isEmpty { self.stopFetch = true }
                transfers.append(contentsOf: response.transfers)
                CacheService().saveIncomingTransactions(address: Web3Service.vitalikEthAddress, transfers: transfers)
                pageKey = response.pageKey
            })
            .store(in: &cancellables)
    }
}

extension TransactionsListViewModel {
    func routeToDetails(model: Model.AssetTransferModel) {
        router.presentDetails(model: model)
    }
}
