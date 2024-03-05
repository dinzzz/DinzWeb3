//
//  TransactionDetailsRouter.swift
//  DinzWeb3
//
//  Created by Dino Bozic on 03.03.2024..
//

import Foundation

protocol TransactionDetailsRouting {
    associatedtype ViewModel: TransactionDetailsViewModeling
    var viewController: TransactionDetailsViewController<ViewModel>? { get set }
    
    func presentDetails(model: Model.AssetTransferModel)
}

class TransactionDetailsRouter: TransactionDetailsRouting {
    weak var viewController: TransactionDetailsViewController<TransactionDetailsViewModel>?
    
    func presentDetails(model: Model.AssetTransferModel) {
        
    }
}
