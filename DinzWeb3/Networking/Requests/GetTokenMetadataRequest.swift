//
//  GetTokenMetadataRequest.swift
//  DinzWeb3
//
//  Created by Dino Bozic on 01.03.2024..
//

import Foundation
import Alamofire

struct GetTokenMetadataRequest: APIRequest {

    typealias ResponseType = Model.GetTokenMetadataResponse
    
    let address: String

    var path: String {
        return Endpoint.getTokenMetadata.path
    }

    var query: [String: String?]?
    var httpMethod: HTTPMethod = .post
    var requestBody: Data? {
        Model.GetTokenMetadataBody.init(params: [address]).data
    }
}

extension Model {
    
    struct GetTokenMetadataResponse: Codable {
        var result: TokenMetadata
    }
    
    struct GetTokenMetadataBody: Codable {
        var id = 1
        var jsonrpc = "2.0"
        var params: [String]
        var method = "alchemy_getTokenMetadata"
    }
}
