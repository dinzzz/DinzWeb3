//
//  TransactionDetailsViewModel.swift
//  DinzWeb3
//
//  Created by Dino Bozic on 03.03.2024..
//

import Foundation
import Combine

protocol TransactionDetailsViewModeling: ObservableObject {
    var context: TransactionDetailsContext { get set }
    
    var transferModel: Model.AssetTransferModel { get }
}

final class TransactionDetailsViewModel: TransactionDetailsViewModeling {
    var context: TransactionDetailsContext
    private let router: any TransactionDetailsRouting
    
    @Published var transferModel: Model.AssetTransferModel
    
    private var cancellables = Set<AnyCancellable>()
    
    init(context: TransactionDetailsContext,
         router: any TransactionDetailsRouting) {
        self.context = context
        self.router = router
        transferModel = context.transfer
    }
}
