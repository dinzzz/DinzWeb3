//
//  NFTDetailsViewModel.swift
//  DinzWeb3
//
//  Created by Dino Bozic on 02.03.2024..
//


import Foundation
import Combine

protocol NFTDetailsViewModeling {
    var context: NFTDetailsContext { get set }
}

final class NFTDetailsViewModel: NFTDetailsViewModeling {
    
    var context: NFTDetailsContext
    private let router: NFTDetailsRouting
    
    init(context: NFTDetailsContext,
         router: NFTDetailsRouting) {
        self.context = context
        self.router = router
    }
}
