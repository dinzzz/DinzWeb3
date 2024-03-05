//
//  WalletDetails+CoreDataProperties.swift
//  DinzWeb3
//
//  Created by Dino Bozic on 02.03.2024..
//

import CoreData
import Foundation

public extension WalletDetails {
    @nonobjc class func fetchRequest() -> NSFetchRequest<WalletDetails> {
        return NSFetchRequest<WalletDetails>(entityName: "WalletDetails")
    }

    @NSManaged var address: String?
    @NSManaged var nftsCount: Int32
    @NSManaged var transactionsCount: Int32
    @NSManaged var accountBalance: String?
    @NSManaged var createdAt: Date?
    @NSManaged var updatedAt: Date?
    @NSManaged var nfts: Set<DBNFTModel>
}
