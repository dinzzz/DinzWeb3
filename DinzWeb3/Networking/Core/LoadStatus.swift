//
//  LoadStatus.swift
//  DinzWeb3
//
//  Created by Dino Bozic on 05.03.2024..
//

import Foundation

enum LoadStatus: Equatable {
    case loading
    case error(Error)
    case none
    
    var isLoading: Bool {
        switch self {
        case .loading:
            return true
        default:
            return false
        }
    }

    static func == (lhs: LoadStatus, rhs: LoadStatus) -> Bool {
        switch (lhs, rhs) {
        case (.loading, .loading), (.none, .none), (.error(_), .error(_)):
            return true
        default:
            return false
        }
    }

    static func != (lhs: LoadStatus, rhs: LoadStatus) -> Bool {
        !(lhs == rhs)
    }
}
