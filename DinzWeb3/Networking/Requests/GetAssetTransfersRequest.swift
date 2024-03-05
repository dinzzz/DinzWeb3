//
//  GetAssetTransfersRequest.swift
//  DinzWeb3
//
//  Created by Dino Bozic on 01.03.2024..
//

import Foundation
import Alamofire

struct GetAssetTransfersFromRequest: APIRequest {

    typealias ResponseType = Model.GetAssetTransfersResponse
    
    let address: String
    var pageKey: String?

    var path: String {
        return Endpoint.getAssetTransfers.path
    }

    var query: [String: String?]?
    var httpMethod: HTTPMethod = .post
    var requestBody: Data? {
        Model.GetAssetTransfersBody.init(params: [.init(fromAddress: address, pageKey: pageKey)]).data
    }
}

struct GetAssetTransfersToRequest: APIRequest {

    typealias ResponseType = Model.GetAssetTransfersResponse
    
    let address: String
    var pageKey: String?

    var path: String {
        return Endpoint.getAssetTransfers.path
    }

    var query: [String: String?]?
    var httpMethod: HTTPMethod = .post
    var requestBody: Data? {
        Model.GetAssetTransfersBody.init(params: [.init(toAddress: address, pageKey: pageKey)]).data
    }
}

extension Model {
    
    struct GetAssetTransfersResponse: Codable {
        var result: GetAssetTransfersResult
    }
    
    struct GetAssetTransfersResult: Codable {
        var transfers: [AssetTransferModel]
        var pageKey: String?
    }
    
    struct GetAssetTransfersParamsBody: Codable {
        var toBlock = "latest"
        var category = ["erc20", "erc721", "external", "internal", "erc1155", "specialnft"]
        var fromAddress: String?
        var toAddress: String?
        var pageKey: String?
    }
    
    struct GetAssetTransfersBody: Codable {
        var id = 1
        var jsonrpc = "2.0"
        var params: [GetAssetTransfersParamsBody]
        var method = "alchemy_getAssetTransfers"
        var pageKey: String?
    }
}
