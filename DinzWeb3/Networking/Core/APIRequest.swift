//
//  APIRequest.swift
//  DinzWeb3
//
//  Created by Dino Bozic on 01.03.2024..
//

import Alamofire
import Foundation

protocol APIRequest: URLRequestConvertible {
    associatedtype ResponseType: Decodable

    var path: String { get }
    var query: [String: String?]? { get }
    var httpMethod: HTTPMethod { get }
    var requestBody: Data? { get }
}

extension APIRequest {

    func asURLRequest() throws -> URLRequest {
        let url = URL(string: path)!

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethod.rawValue
        urlRequest.httpBody = requestBody
        
        query == nil ? () : query?.forEach { urlRequest.url?.appendQueryItem(name: $0.key, value: $0.value) }

        urlRequest.setValue("application/json",
                            forHTTPHeaderField: "content-Type")
        urlRequest.setValue("application/json",
                            forHTTPHeaderField: "accept")

        return urlRequest
    }
}

extension URL {
    mutating func appendQueryItem(name: String, value: String?) {
        guard var urlComponents = URLComponents(string: absoluteString) else { return }
        var queryItems: [URLQueryItem] = urlComponents.queryItems ?? []
        if let value = value {
            let queryItem = URLQueryItem(name: name, value: value)
            queryItems.append(queryItem)
        }
        urlComponents.queryItems = queryItems
        self = urlComponents.url!
    }
}
