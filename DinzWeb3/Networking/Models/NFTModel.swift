//
//  NFTModel.swift
//  DinzWeb3
//
//  Created by Dino Bozic on 01.03.2024..
//

import Foundation

extension Model {

    struct NFTModel: Codable, Equatable {
        var contract: NFTContract
        var description: String?
        var image: NFTImage?
        
        var nftDescription: String? {
            description ?? contract.openSeaMetadata?.description
        }
        
        var nftImageUrl: String? {
            image?.thumbnailUrl ?? contract.openSeaMetadata?.imageUrl
        }
    }
    
    struct NFTContract: Codable, Equatable {
        var address: String
        var name: String?
        var symbol: String?
        var openSeaMetadata: NFTOpenSeaMetadata?
    }
    
    struct NFTImage: Codable, Equatable {
        var thumbnailUrl: String?
        var originalUrl: String?
    }
    
    struct NFTOpenSeaMetadata: Codable, Equatable {
        var collectionName: String?
        var description: String?
        var imageUrl: String?
    }
}
