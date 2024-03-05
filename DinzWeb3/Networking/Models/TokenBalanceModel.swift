//
//  TokenBalanceModel.swift
//  DinzWeb3
//
//  Created by Dino Bozic on 01.03.2024..
//

import Foundation

extension Model {

    struct TokenBalance: Codable, Equatable {
        var contractAddress: String
        var tokenBalance: String
    }
}
