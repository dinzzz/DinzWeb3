//
//  AssetTransferModel.swift
//  DinzWeb3
//
//  Created by Dino Bozic on 01.03.2024..
//

import Foundation

extension Model {

    struct AssetTransferModel: Codable, Equatable {
        var blockNum: String?
        var from: String?
        var to: String?
        var category: String?
        var value: Double?
        var rawContract: AssetTransferContract?
    }
    
    struct AssetTransferContract: Codable, Equatable {
        var address: String?
    }
}
