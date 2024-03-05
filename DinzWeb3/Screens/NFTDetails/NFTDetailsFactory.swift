//
//  NFTDetailsFactory.swift
//  DinzWeb3
//
//  Created by Dino Bozic on 02.03.2024..
//

import Foundation
import UIKit

class NFTDetailsFactory {
    
    func viewController(context: NFTDetailsContext) -> NFTDetailsViewController {
        let router = NFTDetailsRouter()
        let viewModel = NFTDetailsViewModel(context: context, router: router)
        let viewController = NFTDetailsViewController(viewModel: viewModel)
        router.viewController = viewController
        return viewController
    }

    func push(on navigationController: UINavigationController?, animated: Bool = true, context: NFTDetailsContext) {
        navigationController?.pushViewController(viewController(context: context), animated: animated)
    }

    func present(on presentingViewController: UIViewController, context: NFTDetailsContext) {
        presentingViewController.present(viewController(context: context), animated: true)
    }
}
