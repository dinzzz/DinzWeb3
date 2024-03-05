//
//  TransactionDetailsViewController.swift
//  DinzWeb3
//
//  Created by Dino Bozic on 03.03.2024..
//

import UIKit
import SwiftUI
import Combine

final class TransactionDetailsViewController<ViewModel: TransactionDetailsViewModeling>: UIHostingController<TransactionDetailsViewUI<ViewModel>> {
    
    let viewModel: ViewModel
    private let contentView: TransactionDetailsViewUI<ViewModel>

    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        contentView = TransactionDetailsViewUI(viewModel: viewModel)
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
    }

    private func observe() {
    }
}
