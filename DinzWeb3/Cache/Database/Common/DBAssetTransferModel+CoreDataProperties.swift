//
//  DBAssetTransferModel+CoreDataProperties.swift
//  DinzWeb3
//
//  Created by Dino Bozic on 05.03.2024..
//

import CoreData

public extension DBAssetTransferModel {
    @NSManaged var blockNum: String?
    @NSManaged var address: String?
    @NSManaged var from: String?
    @NSManaged var to: String?
    @NSManaged var category: String?
    @NSManaged var value: NSNumber?
}
