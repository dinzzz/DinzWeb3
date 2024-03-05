//
//  MockWeb3Service.swift
//  DinzWeb3Tests
//
//  Created by Dino Bozic on 04.03.2024..
//

import XCTest
@testable import DinzWeb3
import Combine

final class MockWeb3Service: Web3Servicing {
    
    var getToAssetResult: AnyPublisher<DinzWeb3.Model.GetAssetTransfersResult, DinzWeb3.Model.ApiError> = Just(.init(transfers: [Model.AssetTransferModel(from: "From address1", to: "To address2"), Model.AssetTransferModel(from: "From address2", to: "To address1")])).setFailureType(to: DinzWeb3.Model.ApiError.self).eraseToAnyPublisher()
    
    var getOwnedNFTsResult: AnyPublisher<DinzWeb3.Model.GetNFTsForOwnerResponse, DinzWeb3.Model.ApiError> = Just(Model.GetNFTsForOwnerResponse(ownedNfts: [.init(contract: .init(address: "nft1Address")), .init(contract: .init(address: "nft2Address"))], totalCount: 2)).setFailureType(to: DinzWeb3.Model.ApiError.self).eraseToAnyPublisher()
    
     
    var getETHBalanceResult: AnyPublisher<DinzWeb3.Model.ETHBalanceModel, DinzWeb3.Model.ApiError> = Just(Model.ETHBalanceModel(result: "ETHBalanceResult")).setFailureType(to: DinzWeb3.Model.ApiError.self).eraseToAnyPublisher()
    
    func getETHBalance(address: String) -> AnyPublisher<DinzWeb3.Model.ETHBalanceModel, DinzWeb3.Model.ApiError> {
        getETHBalanceResult
    }
    
    func getOwnedNFTs(ownerAddress: String, pageKey: String?) -> AnyPublisher<DinzWeb3.Model.GetNFTsForOwnerResponse, DinzWeb3.Model.ApiError> {
        getOwnedNFTsResult
    }
    
    func getTokenMetadata(address: String) -> AnyPublisher<DinzWeb3.Model.TokenMetadata, DinzWeb3.Model.ApiError> {
        Just(Model.TokenMetadata(decimals: 2, logoURLString: "logoURL", name: "name", symbol: "symbol")).setFailureType(to: DinzWeb3.Model.ApiError.self).eraseToAnyPublisher()
    }
    
    func getTokenBalances(address: String) -> AnyPublisher<[DinzWeb3.Model.TokenBalance], DinzWeb3.Model.ApiError> {
        Just([Model.TokenBalance(contractAddress: "tokenBalanceAddress", tokenBalance: "tokenBalanceHex"), Model.TokenBalance(contractAddress: "tokenBalanceAddress", tokenBalance: "tokenBalanceHex")]).setFailureType(to: DinzWeb3.Model.ApiError.self).eraseToAnyPublisher()
    }
    
    func getTransactionCount(address: String) -> AnyPublisher<String, DinzWeb3.Model.ApiError> {
        Just("25").setFailureType(to: DinzWeb3.Model.ApiError.self).eraseToAnyPublisher()
    }
    
    func getFromAssetTransfers(address: String) -> AnyPublisher<[DinzWeb3.Model.AssetTransferModel], DinzWeb3.Model.ApiError> {
        Just([Model.AssetTransferModel(from: "From address1", to: "To address2"), Model.AssetTransferModel(from: "From address2", to: "To address1")]).setFailureType(to: DinzWeb3.Model.ApiError.self).eraseToAnyPublisher()
    }
    
    func getToAssetTransfers(address: String, pageKey: String?) -> AnyPublisher<DinzWeb3.Model.GetAssetTransfersResult, DinzWeb3.Model.ApiError> {
        getToAssetResult
    }
}
