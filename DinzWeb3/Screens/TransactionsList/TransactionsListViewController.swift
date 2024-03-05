//
//  TransactionsListViewController.swift
//  DinzWeb3
//
//  Created by Dino Bozic on 03.03.2024..
//

import UIKit
import SwiftUI
import Combine

class TransactionsListViewController<ViewModel: TransactionsListViewModeling>: UIHostingController<TransactionsListViewUI<ViewModel>> {
    
    let viewModel: ViewModel
    private let contentView: TransactionsListViewUI<ViewModel>

    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        contentView = TransactionsListViewUI(viewModel: viewModel)
        super.init(rootView: contentView)
        view.backgroundColor = UIStyle.Color.Background.primary
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        observe()
        viewModel.onViewDidLoad()
    }

    private func observe() {
    }
}
