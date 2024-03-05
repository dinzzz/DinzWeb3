//
//  GetTokenBalancesRequest.swift
//  DinzWeb3
//
//  Created by Dino Bozic on 01.03.2024..
//

import Foundation
import Alamofire

struct GetTokenBalancesRequest: APIRequest {

    typealias ResponseType = Model.GetTokenBalancesResponse
    
    let address: String

    var path: String {
        return Endpoint.getTokenBalances.path
    }

    var query: [String: String?]?
    var httpMethod: HTTPMethod = .post
    var requestBody: Data? {
        Model.GetTokenBalancesBody.init(params: [address]).data
    }
}

extension Model {
    
    struct GetTokenBalancesResponse: Codable {
        var result: GetTokenBalancesResult
    }
    
    struct GetTokenBalancesResult: Codable {
        var tokenBalances: [TokenBalance]
    }
    
    struct GetTokenBalancesBody: Codable {
        var id = 1
        var jsonrpc = "2.0"
        var params: [String]
        var method = "alchemy_getTokenBalances"
    }
}
