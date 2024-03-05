//
//  GetTransactionCountRequest.swift
//  DinzWeb3
//
//  Created by Dino Bozic on 01.03.2024..
//

import Foundation
import Alamofire

struct GetTransactionCountRequest: APIRequest {

    typealias ResponseType = Model.GetTransactionCountResponse
    
    let address: String

    var path: String {
        return Endpoint.getTransactionCount.path
    }

    var query: [String: String?]?
    var httpMethod: HTTPMethod = .post
    var requestBody: Data? {
        Model.GetTransactionCountBody.init(params: [address, "latest"]).data
    }
}

extension Model {
    
    struct GetTransactionCountResponse: Codable {
        var result: String
    }
    
    struct GetTransactionCountBody: Codable {
        var id = 1
        var jsonrpc = "2.0"
        var params: [String]
        var method = "eth_getTransactionCount"
    }
}
