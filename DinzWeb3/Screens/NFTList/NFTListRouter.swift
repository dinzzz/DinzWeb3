//
//  NFTListRouter.swift
//  DinzWeb3
//
//  Created by Dino Bozic on 03.03.2024..
//

import Foundation
import UIKit

protocol NFTListRouting {
    var viewController: NFTListViewController? { get set }
    
    func presentNFTDetails(nft: Model.NFTModel)
    func presentAlert(title: String, message: String)
}

class NFTListRouter: NFTListRouting {
    weak var viewController: NFTListViewController?
    
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
}
