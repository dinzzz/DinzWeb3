//
//  DBNFTModel.swift
//  DinzWeb3
//
//  Created by Dino Bozic on 03.03.2024..
//

import Foundation
import CoreData

@objc(DBNFTModel)
public class DBNFTModel: NSManagedObject {
    @discardableResult
    static func from(model: Model.NFTModel, context: NSManagedObjectContext) -> DBNFTModel {
        let nftModel = NSEntityDescription.insertNewObject(forEntityName: "DBNFTModel", into: context) as! DBNFTModel
        nftModel.address = model.contract.address
        nftModel.name = model.contract.name
        nftModel.symbol = model.contract.symbol
        nftModel.nftDescription = model.nftDescription
        nftModel.imageUrl = model.nftImageUrl
        return nftModel
    }

    func toModel() -> Model.NFTModel {
        Model.NFTModel(contract: .init(address: address ?? "",
                                       name: name,
                                       symbol: symbol,
                                       openSeaMetadata: .init(description: nftDescription,
                                                              imageUrl: imageUrl)
                                      )
        )
    }
}
