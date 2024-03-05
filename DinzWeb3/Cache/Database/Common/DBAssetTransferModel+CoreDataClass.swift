//
//  DBAssetTransferModel.swift
//  DinzWeb3
//
//  Created by Dino Bozic on 05.03.2024..
//

import Foundation
import CoreData

@objc(DBAssetTransferModel)
public class DBAssetTransferModel: NSManagedObject {
    @discardableResult
    static func from(model: Model.AssetTransferModel, context: NSManagedObjectContext) -> DBAssetTransferModel {
        let dbModel = NSEntityDescription.insertNewObject(forEntityName: "DBAssetTransferModel", into: context) as! DBAssetTransferModel
        dbModel.address = model.rawContract?.address
        dbModel.blockNum = model.blockNum
        dbModel.from = model.from
        dbModel.to = model.to
        dbModel.category = model.category
        dbModel.value = NSNumber(value: model.value ?? 0)
        return dbModel
    }

    func toModel() -> Model.AssetTransferModel {
        .init(blockNum: blockNum,
              from: from,
              to: to,
              category: category,
              value: value?.doubleValue,
              rawContract: .init(address: address)
        )
    }
}
