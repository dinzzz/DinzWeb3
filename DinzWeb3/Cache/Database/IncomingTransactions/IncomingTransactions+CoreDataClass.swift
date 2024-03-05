//
//  IncomingTransactions+CoreDataClass.swift
//  DinzWeb3
//
//  Created by Dino Bozic on 04.03.2024..
//

import CoreData
import Foundation

extension Model {
    struct IncomingTransactionsCacheModel {
        var address: String
        var transactions: [Model.AssetTransferModel]
    }
}

@objc(IncomingTransactions)
public class IncomingTransactions: NSManagedObject {
    @discardableResult
    static func from(model: Model.IncomingTransactionsCacheModel, context: NSManagedObjectContext) -> IncomingTransactions {
        let walletDetails = NSEntityDescription.insertNewObject(forEntityName: "IncomingTransactions", into: context) as! IncomingTransactions
        walletDetails.address = model.address
        walletDetails.transfers = Set(model.transactions.map { DBAssetTransferModel.from(model: $0, context: context) })
        return walletDetails
    }

    func toModel() -> Model.IncomingTransactionsCacheModel {
        Model.IncomingTransactionsCacheModel(address: address ?? "",
                                             transactions: transfers.map { $0.toModel() })
    }
}
