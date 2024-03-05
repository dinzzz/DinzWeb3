//
//  HomeScreenRouter.swift
//  DinzWeb3
//
//  Created by Dino Bozic on 29.02.2024..
//

import Foundation
import UIKit

protocol HomeScreenRouting {
    var viewController: HomeScreenViewController? { get set }
    
    func presentAlert(title: String, message: String)
    func presentNFTDetails(nft: Model.NFTModel)
    func presentNFTList()
    func presentTransactionList()
}

class HomeScreenRouter: HomeScreenRouting {
    weak var viewController: HomeScreenViewController?
    
    func presentAlert(title: String, message: String) {
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        alertController.addAction(.init(title: "Ok", style: .default))
        
        viewController?.present(alertController, animated: true, completion: nil)
    }
    
    func presentNFTDetails(nft: Model.NFTModel) {
        guard let viewController = viewController else { return }
        NFTDetailsFactory().present(on: viewController, context: .init(nft: nft))
    }
    
    func presentNFTList() {
        guard let viewController = viewController else { return }
        NFTListFactory().present(on: viewController, context: .init(address: Web3Service.vitalikEthAddress))
    }
    
    func presentTransactionList() {
        guard let viewController = viewController else { return }
        TransactionsListFactory().present(on: viewController, context: .init())
    }
}
