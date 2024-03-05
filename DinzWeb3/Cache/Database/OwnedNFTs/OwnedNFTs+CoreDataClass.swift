//
//  OwnedNFTs+CoreDataClass.swift
//  DinzWeb3
//
//  Created by Dino Bozic on 04.03.2024..
//

import CoreData
import Foundation

extension Model {
    struct OwnerNftsCacheModel {
        var address: String
        var nfts: [Model.NFTModel]
    }
}

@objc(OwnedNFTs)
public class OwnedNFTs: NSManagedObject {
    @discardableResult
    static func from(model: Model.OwnerNftsCacheModel, context: NSManagedObjectContext) -> OwnedNFTs {
        let walletDetails = NSEntityDescription.insertNewObject(forEntityName: "OwnedNFTs", into: context) as! OwnedNFTs
        walletDetails.address = model.address
        walletDetails.nfts = Set(model.nfts.map { DBNFTModel.from(model: $0, context: context) })
        return walletDetails
    }

    func toModel() -> Model.OwnerNftsCacheModel {
        Model.OwnerNftsCacheModel(address: address ?? "",
                         nfts: nfts.map { $0.toModel() })
    }
}
