//
//  TransactionDetailsFactory.swift
//  DinzWeb3
//
//  Created by Dino Bozic on 03.03.2024..
//

import Foundation
import UIKit

class TransactionDetailsFactory {
    
    func viewController(context: TransactionDetailsContext) -> TransactionDetailsViewController<TransactionDetailsViewModel> {
        let router = TransactionDetailsRouter()
        let viewModel = TransactionDetailsViewModel(context: context, router: router)
        let viewController = TransactionDetailsViewController(viewModel: viewModel)
        router.viewController = viewController
        

        
        return viewController
    }

    func push(on navigationController: UINavigationController?, animated: Bool = true, context: TransactionDetailsContext) {
        navigationController?.pushViewController(viewController(context: context), animated: animated)
    }

    func present(on presentingViewController: UIViewController, context: TransactionDetailsContext) {
        let viewController = viewController(context: context)
        
        let vcNavigationContoller = UINavigationController(rootViewController: viewController)
        vcNavigationContoller.modalPresentationStyle = .pageSheet
        if let sheet = vcNavigationContoller.sheetPresentationController {
            sheet.detents = [.custom(resolver: { context in
                450
            })]
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 16
        }
        
        
        presentingViewController.present(vcNavigationContoller, animated: true)
    }
}
