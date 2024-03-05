//
//  RootViewController.swift
//  DinzWeb3
//
//  Created by Dino Bozic on 01.03.2024..
//

import UIKit
import Combine
import SwiftUI

final class RootViewController: UINavigationController {
    
    static let shared = RootViewController(viewModel: RootViewModel())
    
    private var viewModel: RootViewModel
    
    private init(viewModel: RootViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        view.backgroundColor = .white
        startApp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBarHidden(true, animated: false)
    }
    
    private func startApp() {
        let homeVC = HomeScreenFactory().viewController(context: HomeScreenContext())
        setViewControllers([homeVC], animated: false)
    }
}
