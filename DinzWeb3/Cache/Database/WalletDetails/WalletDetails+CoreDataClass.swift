//
//  WalletDetails+CoreDataClass.swift
//  DinzWeb3
//
//  Created by Dino Bozic on 02.03.2024..
//

import CoreData
import Foundation

extension Model {
    struct CacheModel {
        var address: String
        var nftsCount: Int
        var transactionsCount: Int
        var accountBalance: String
        var createdAt: Date
        var updatedAt: Date
        var nfts: [Model.NFTModel]
    }
}

@objc(WalletDetails)
public class WalletDetails: NSManagedObject {
    @discardableResult
    static func from(model: Model.CacheModel, context: NSManagedObjectContext) -> WalletDetails {
        let walletDetails = NSEntityDescription.insertNewObject(forEntityName: "WalletDetails", into: context) as! WalletDetails
        walletDetails.address = model.address
        walletDetails.nftsCount = Int32(model.nftsCount)
        walletDetails.transactionsCount = Int32(model.transactionsCount)
        walletDetails.accountBalance = model.accountBalance
        walletDetails.createdAt = model.createdAt
        walletDetails.updatedAt = model.updatedAt
        walletDetails.nfts = Set(model.nfts.map { DBNFTModel.from(model: $0, context: context) })
        return walletDetails
    }

    func toModel() -> Model.CacheModel {
        Model.CacheModel(address: address ?? "",
                         nftsCount: Int(nftsCount),
                         transactionsCount: Int(transactionsCount),
                         accountBalance: accountBalance ?? "",
                         createdAt: createdAt ?? Date(),
                         updatedAt: updatedAt ?? Date(),
                         nfts: nfts.map { $0.toModel() })
    }
}
