//
//  TransactionsListRouter.swift
//  DinzWeb3
//
//  Created by Dino Bozic on 03.03.2024..
//

import Foundation
import UIKit

protocol TransactionsListRouting {
    associatedtype ViewModel: TransactionsListViewModeling
    var viewController: TransactionsListViewController<ViewModel>? { get set }
    
    func presentDetails(model: Model.AssetTransferModel)
    func presentAlert(title: String, message: String)
}

class TransactionsListRouter: TransactionsListRouting {
    weak var viewController: TransactionsListViewController<TransactionsListViewModel>?
    
    func presentDetails(model: Model.AssetTransferModel) {
        guard let viewController = viewController else { return }
        TransactionDetailsFactory().present(on: viewController, context: .init(transfer: model))
    }
    
    func presentAlert(title: String, message: String) {
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        alertController.addAction(.init(title: "Ok", style: .default))
        
        viewController?.present(alertController, animated: true, completion: nil)
    }
}
