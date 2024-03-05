//
//  TransactionsListFactory.swift
//  DinzWeb3
//
//  Created by Dino Bozic on 03.03.2024..
//

import Foundation
import UIKit

class TransactionsListFactory {
    
    func viewController(context: TransactionsListContext) -> TransactionsListViewController<TransactionsListViewModel> {
        let router = TransactionsListRouter()
        let viewModel = TransactionsListViewModel(context: context, router: router)
        let viewController = TransactionsListViewController(viewModel: viewModel)
        router.viewController = viewController
        return viewController
    }

    func push(on navigationController: UINavigationController?, animated: Bool = true, context: TransactionsListContext) {
        navigationController?.pushViewController(viewController(context: context), animated: animated)
    }

    func present(on presentingViewController: UIViewController, context: TransactionsListContext) {
        presentingViewController.present(viewController(context: context), animated: true)
    }
}
