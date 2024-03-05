//
//  Web3Service.swift
//  DinzWeb3
//
//  Created by Dino Bozic on 01.03.2024..
//

import Foundation
import Combine
import Web3

protocol Web3Servicing {
    func getETHBalance(address: String) -> AnyPublisher<Model.ETHBalanceModel, Model.ApiError>
    func getOwnedNFTs(ownerAddress: String, pageKey: String?) -> AnyPublisher<Model.GetNFTsForOwnerResponse, Model.ApiError>
    func getTokenMetadata(address: String) -> AnyPublisher<Model.TokenMetadata, Model.ApiError>
    func getTokenBalances(address: String) -> AnyPublisher<[Model.TokenBalance], Model.ApiError>
    func getTransactionCount(address: String) -> AnyPublisher<String, Model.ApiError>
    func getFromAssetTransfers(address: String) -> AnyPublisher<[Model.AssetTransferModel], Model.ApiError>
    func getToAssetTransfers(address: String, pageKey: String?) -> AnyPublisher<Model.GetAssetTransfersResult, Model.ApiError>
}

final class Web3Service: Web3Servicing {
    
    static let alchemyAPIKey = "MaMj7kGp01U3RudVUhUk_JmKHklcNCoB"
    static let vitalikEthAddress = "0xd8da6bf26964af9d7eed9e03e53415d37aa96045"
    
    func getETHBalance(address: String) -> AnyPublisher<Model.ETHBalanceModel, Model.ApiError> {
        APIClient.shared.performRequest(GetETHBalanceRequest(address: address))
            .map { Model.ETHBalanceModel(result: $0.result)}
            .eraseToAnyPublisher()
    }
    
    func getOwnedNFTs(ownerAddress: String, pageKey: String? = nil) -> AnyPublisher<Model.GetNFTsForOwnerResponse, Model.ApiError> {
        APIClient.shared.performRequest(GetNFTsForOwnerRequest(ownerAddress: ownerAddress, pageKey: pageKey))
            .map { $0 }
            .eraseToAnyPublisher()
    }
    
    func getTokenMetadata(address: String) -> AnyPublisher<Model.TokenMetadata, Model.ApiError> {
        APIClient.shared.performRequest(GetTokenMetadataRequest(address: address))
            .map { $0.result }
            .eraseToAnyPublisher()
    }
    
    func getTokenBalances(address: String) -> AnyPublisher<[Model.TokenBalance], Model.ApiError> {
        APIClient.shared.performRequest(GetTokenBalancesRequest(address: address))
            .map { $0.result.tokenBalances }
            .eraseToAnyPublisher()
    }
    
    func getTransactionCount(address: String) -> AnyPublisher<String, Model.ApiError> {
        APIClient.shared.performRequest(GetTransactionCountRequest(address: address))
            .map { $0.result }
            .eraseToAnyPublisher()
    }
    
    func getFromAssetTransfers(address: String) -> AnyPublisher<[Model.AssetTransferModel], Model.ApiError> {
        APIClient.shared.performRequest(GetAssetTransfersFromRequest(address: address))
            .map { $0.result.transfers }
            .eraseToAnyPublisher()
    }
    
    func getToAssetTransfers(address: String, pageKey: String? = nil) -> AnyPublisher<Model.GetAssetTransfersResult, Model.ApiError> {
        APIClient.shared.performRequest(GetAssetTransfersToRequest(address: address, pageKey: pageKey))
            .map { $0.result }
            .eraseToAnyPublisher()
    }
}

extension Web3Service {
    static func convertToDouble(hexValue: String) -> Double? {
        guard let bigUIntValue = BigUInt(hexValue.dropFirst(2), radix: 16) else {
            return nil
        }
        
        let value = Double(bigUIntValue) / pow(10, 18)
        return value
    }
    
    static func convertToInt(hexValue: String) -> Int? {
        Int(hexValue.dropFirst(2), radix: 16)
    }
}
