//
//  OwnedNFTs+CoreDataProperties.swift
//  DinzWeb3
//
//  Created by Dino Bozic on 04.03.2024..
//

import CoreData
import Foundation

public extension OwnedNFTs {
    @nonobjc class func fetchRequest() -> NSFetchRequest<OwnedNFTs> {
        return NSFetchRequest<OwnedNFTs>(entityName: "OwnedNFTs")
    }

    @NSManaged var address: String?
    @NSManaged var nfts: Set<DBNFTModel>
}
