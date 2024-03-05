//
//  APIClient.swift
//  DinzWeb3
//
//  Created by Dino Bozic on 01.03.2024..
//

import Alamofire
import Foundation
import Combine

class APIClient {
    static let shared = APIClient()
    
    let decoder = JSONDecoder()
    
    private var cancellables: Set<AnyCancellable> = .init()
    
    func performRequest<T: APIRequest>(_ request: T) -> AnyPublisher<T.ResponseType, Model.ApiError> {
        Future<T.ResponseType, Model.ApiError> { promise in
            AF.request(request)
                .validate()
                .responseDecodable(decoder: self.decoder) { (response: DataResponse<T.ResponseType, AFError>) in
                    switch response.result {
                    case .success(let value):
                        promise(.success(value))
                    case .failure(_):
                        // Debug
                        do {
                            let _ = try self.decoder.decode(T.ResponseType.self, from: response.data ?? Data())
                        } catch {
                            print("Decoding error")
                            print(error)
                        }
                        
                        do {
                            let errorResponse = try self.decoder.decode(Model.ApiError.self, from: response.data ?? Data())
                            promise(.failure(errorResponse))
                        } catch {
                            promise(.failure(Model.ApiError.unknown))
                        }
                    }
                }
        }.eraseToAnyPublisher()
    }
}

extension Encodable {
    
    var data: Data? {
        if let data = self as? Data {
            return data
        }
        
        return try? JSONEncoder().encode(self)
    }
    
    
    
    var dictionaryOptional: [String: Any]? {
        guard let data = data else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
}
