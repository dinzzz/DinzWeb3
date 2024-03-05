//
//  NFTListViewController.swift
//  DinzWeb3
//
//  Created by Dino Bozic on 03.03.2024..
//

import Foundation
import UIKit
import Combine

class NFTListViewController: UIViewController {
    
    var viewModel: NFTListViewModeling
    
    //MARK: - Views
    
    lazy var contentView: NFTListContentView = {
        let view = NFTListContentView()
        view.tableView.dataSource = self
        view.tableView.delegate = self
        return view
    }()
    
    //MARK: - Properties
    
    private var cancellables = Set<AnyCancellable>()

    init(viewModel: NFTListViewModeling) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        view.backgroundColor = UIStyle.Color.Background.primary
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setConstraints()
        observe()
        
        viewModel.onViewDidLoad()
    }
    
    private func addSubviews() {
        view.addSubview(contentView)
    }
    
    private func setConstraints() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: view.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func observe() {
        viewModel.reloadTablePublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self else { return }
                self.contentView.tableView.reloadData()
            }.store(in: &cancellables)
    }
}

extension NFTListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch viewModel.dataSource[indexPath.row] {
        case .nft(let cellViewModel):
            let cell: NFTListItemTableViewCell = tableView.dequeueCellAtIndexPath(indexPath: indexPath)
            cell.setup(cellViewModel)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        viewModel.willDisplay(at: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch viewModel.dataSource[indexPath.row] {
        case .nft(let cellViewModel):
            viewModel.routeToNFTDetails(nft: cellViewModel.nft)
        }
    }
}
