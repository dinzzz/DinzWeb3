//
//  GetNFTsForOwnerRequest.swift
//  DinzWeb3
//
//  Created by Dino Bozic on 01.03.2024..
//


import Foundation
import Alamofire

struct GetNFTsForOwnerRequest: APIRequest {

    typealias ResponseType = Model.GetNFTsForOwnerResponse
    
    let ownerAddress: String
    var pageKey: String?

    var path: String {
        return Endpoint.getNFTsForOwner.path
    }

    var query: [String: String?]? {
        pageKey == nil ? ["owner": ownerAddress] : ["owner": ownerAddress, "pageKey": pageKey]
        
    }
    var httpMethod: HTTPMethod = .get
    var requestBody: Data?
}

extension Model {
    
    struct GetNFTsForOwnerResponse: Codable {
        var ownedNfts: [NFTModel]
        var totalCount: Int
        var pageKey: String?
    }
}
