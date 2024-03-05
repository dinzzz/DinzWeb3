//
//  ETHBalanceModel.swift
//  DinzWeb3
//
//  Created by Dino Bozic on 01.03.2024..
//

import Foundation

extension Model {

    struct ETHBalanceModel: Codable {
        var result: String
        
        var balance: Double? {
            Web3Service.convertToDouble(hexValue: result)
        }
        
        var balanceString: String? {
            guard let balance = balance else { return nil }
            return String(format: "%.4f", balance)
        }
    }
}
