//
//  IncomingTransactions+CoreDataProperties.swift
//  DinzWeb3
//
//  Created by Dino Bozic on 04.03.2024..
//

import CoreData
import Foundation

public extension IncomingTransactions {
    @nonobjc class func fetchRequest() -> NSFetchRequest<IncomingTransactions> {
        return NSFetchRequest<IncomingTransactions>(entityName: "IncomingTransactions")
    }

    @NSManaged var address: String?
    @NSManaged var transfers: Set<DBAssetTransferModel>
}
