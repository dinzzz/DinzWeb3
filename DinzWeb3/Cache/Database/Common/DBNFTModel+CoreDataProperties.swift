//
//  DBNFTModel+CoreDataProperties.swift
//  DinzWeb3
//
//  Created by Dino Bozic on 03.03.2024..
//

import CoreData

public extension DBNFTModel {
    @NSManaged var address: String?
    @NSManaged var name: String?
    @NSManaged var symbol: String?
    @NSManaged var nftDescription: String?
    @NSManaged var imageUrl: String?
}
