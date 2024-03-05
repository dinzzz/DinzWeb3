//
//  CacheService.swift
//  DinzWeb3
//
//  Created by Dino Bozic on 03.03.2024..
//

import Foundation

class CacheService {
    
    func saveToCache(address: String, nftsCount: Int, transactionsCount: Int, accBalance: String, nfts: [Model.NFTModel]) {
        WalletDetailsDatabaseService.shared.saveOrUpdateWalletDetails(model: .init(address: address,
                                                                                   nftsCount: nftsCount,
                                                                                   transactionsCount: transactionsCount,
                                                                                   accountBalance: accBalance,
                                                                                   createdAt: Date(),
                                                                                   updatedAt: Date(),
                                                                                   nfts: nfts))
    }
    
    func saveOwnedNftsToCache(address: String, nfts: [Model.NFTModel]) {
        OwnedNFTsDatabaseService.shared.saveOrUpdateWalletDetails(model: .init(address: address, nfts: nfts))
    }
    
    func saveIncomingTransactions(address: String, transfers: [Model.AssetTransferModel]) {
        IncomingTransactionsDatabaseService.shared.saveOrUpdateWalletDetails(model: .init(address: address, transactions: transfers))
    }
}
