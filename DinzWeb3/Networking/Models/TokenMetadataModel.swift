//
//  TokenMetadataModel.swift
//  DinzWeb3
//
//  Created by Dino Bozic on 01.03.2024..
//

extension Model {

    struct TokenMetadata: Codable {
        var decimals: Int
        var logoURLString: String
        var name: String
        var symbol: String
    }
}
