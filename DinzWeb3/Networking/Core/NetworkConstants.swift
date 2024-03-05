//
//  NetworkConstants.swift
//  DinzWeb3
//
//  Created by Dino Bozic on 01.03.2024..
//

import Foundation

struct NetworkConstants {
    static let baseURL = URL(string: baseURLString)!
    static var baseURLString = "https://eth-mainnet.g.alchemy.com/v2/\(Web3Service.alchemyAPIKey)"
    
    static let baseURLNFTs = URL(string: baseURLNFTsString)!
    static var baseURLNFTsString = "https://eth-mainnet.g.alchemy.com/nft/v3/\(Web3Service.alchemyAPIKey)"
}
