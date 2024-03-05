//
//  NFTListFactory.swift
//  DinzWeb3
//
//  Created by Dino Bozic on 03.03.2024..
//

import Foundation
import UIKit

class NFTListFactory {
    
    func viewController(context: NFTListContext) -> NFTListViewController {
        let router = NFTListRouter()
        let viewModel = NFTListViewModel(context: context, router: router)
        let viewController = NFTListViewController(viewModel: viewModel)
        router.viewController = viewController
        return viewController
    }

    func push(on navigationController: UINavigationController?, animated: Bool = true, context: NFTListContext) {
        navigationController?.pushViewController(viewController(context: context), animated: animated)
    }

    func present(on presentingViewController: UIViewController, context: NFTListContext) {
        presentingViewController.present(viewController(context: context), animated: true)
    }
}
