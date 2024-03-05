//
//  ErrorResponse.swift
//  DinzWeb3
//
//  Created by Dino Bozic on 01.03.2024..
//

import Foundation
import Alamofire

extension Model {
    
    enum ResultType: Int, Codable {
        case success = 0
        case warning = 1
        case error = 2
    }
    
    enum ErrorCode: String, Codable {
        case unknown = "unknown"
        case decodingError = "decodingError"

        var description: String {
            switch self {
            case .unknown:
                return "Unknown"
            case .decodingError:
                return "Decoding Error"
                
            }
        }
    }
    
    struct ApiError: Error, Codable, Equatable {
        
        static let unknown: ApiError = .init(code: .unknown)
        
        let errorMessage: String
        let resultType: ResultType
        let statusCode: Int?
        
        init(
            errorMessage: String,
            resultType: ResultType,
            statusCode: Int?
        ) {
            self.errorMessage = errorMessage
            self.resultType = resultType
            self.statusCode = statusCode
        }
        
        init(from error: Error) {
            errorMessage = error.localizedDescription
            resultType = .error
            statusCode = nil
        }
        
        init(code errorCode: ErrorCode) {
            errorMessage = errorCode.description
            resultType = .error
            statusCode = nil
        }
        
        init(from afError: AFError) {
            errorMessage = afError.localizedDescription
            resultType = .error
            statusCode = nil
        }
    }
}
