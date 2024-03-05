//
//  GetETHBalanceRequest.swift
//  DinzWeb3
//
//  Created by Dino Bozic on 01.03.2024..
//

import Foundation
import Alamofire

struct GetETHBalanceRequest: APIRequest {

    typealias ResponseType = Model.GetETHBalanceResponse
    
    let address: String

    var path: String {
        return Endpoint.getETHBalance.path
    }

    var query: [String: String?]?
    var httpMethod: HTTPMethod = .post
    var requestBody: Data? {
        Model.GetETHBalanceBody.init(params: [address, "latest"]).data
    }
}

extension Model {
    
    struct GetETHBalanceResponse: Codable {
        var result: String
    }
    
    struct GetETHBalanceBody: Codable {
        var id = 1
        var jsonrpc = "2.0"
        var params: [String]
        var method = "eth_getBalance"
    }
}
