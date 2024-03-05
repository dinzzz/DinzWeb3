//
//  HomeScreenFactory.swift
//  DinzWeb3
//
//  Created by Dino Bozic on 29.02.2024..
//

import Foundation
import UIKit

class HomeScreenFactory {
    
    func viewController(context: HomeScreenContext) -> HomeScreenViewController {
        let router = HomeScreenRouter()
        let viewModel = HomeScreenViewModel(context: context, router: router)
        let viewController = HomeScreenViewController(viewModel: viewModel)
        router.viewController = viewController
        return viewController
    }

    func push(on navigationController: UINavigationController?, animated: Bool = true, context: HomeScreenContext) {
        navigationController?.pushViewController(viewController(context: context), animated: animated)
    }

    func present(on presentingViewController: UIViewController, context: HomeScreenContext) {
        presentingViewController.present(viewController(context: context), animated: true)
    }
}
