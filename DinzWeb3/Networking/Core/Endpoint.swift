//
//  Endpoint.swift
//  DinzWeb3
//
//  Created by Dino Bozic on 01.03.2024..
//

import Foundation

enum Endpoint {
    case fullPath(String)
    
    //MARK: - v2 Ethereum
    case getETHBalance
    case getTokenBalances
    case getTokenMetadata
    case getTransactionCount
    case getAssetTransfers
    
    //MARK: - NFTs
    case getNFTsForOwner
    
    var path: String {
        switch self {
        case .fullPath:
            return _path
        case .getNFTsForOwner:
            return NetworkConstants.baseURLNFTsString + _path
        default:
            return NetworkConstants.baseURLString + _path
        }
    }
    
    private var _path: String {
        switch self {
        case .getETHBalance, .getTokenBalances, .getTokenMetadata, .getTransactionCount, .getAssetTransfers:
            return ""
        case .getNFTsForOwner:
            return "/getNFTsForOwner"
        case .fullPath(let path):
            return path
        }
    }
}
