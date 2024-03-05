//
//  NFTListViewControllerTests.swift
//  DinzWeb3Tests
//
//  Created by Dino Bozic on 04.03.2024..
//

import XCTest
@testable import DinzWeb3
import Combine

class NFTListViewControllerTests: XCTestCase {

    var viewController: NFTListViewController!
    var viewModel: MockNFTListViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = MockNFTListViewModel(context: .init(address: ""))
        viewController = NFTListViewController(viewModel: viewModel)
        viewController.loadViewIfNeeded()
    }

    override func tearDown() {
        viewController = nil
        viewModel = nil
        super.tearDown()
    }

    func testInitialization() {
        XCTAssertNotNil(viewController)
    }
    
    func testViewDidLoad() {
        viewController.viewDidLoad()
        XCTAssertTrue(viewModel.didCallOnViewDidLoad)
    }

    func testTableViewDataSourceMethods() {
        // Given
        let tableView = viewController.contentView.tableView

        viewModel.dataSource = [.nft(.init(nft: .init(contract: .init(address: ""))))]
        
        // When
        let numberOfRows = viewController.tableView(tableView, numberOfRowsInSection: 0)
        let cell = viewController.tableView(tableView, cellForRowAt: IndexPath(row: 0, section: 0))

        // Then
        XCTAssertEqual(numberOfRows, 1)
        XCTAssertTrue(cell is NFTListItemTableViewCell)
    }
    
    func testTableViewDelegateMethods() {
        // Given
        let tableView = viewController.contentView.tableView
        
        viewModel.dataSource = [.nft(.init(nft: .init(contract: .init(address: ""))))]
        
        // When
        viewController.tableView(tableView, didSelectRowAt: IndexPath(row: 0, section: 0))

        // Then
        XCTAssertTrue(viewModel.didCallRouteToNFTDetails)
    }
    
    func testTableViewWillDisplay() {
        // Given
        let tableView = viewController.contentView.tableView
        
        viewModel.dataSource = [.nft(.init(nft: .init(contract: .init(address: ""))))]
        
        // When
        viewController.tableView(tableView, willDisplay: UITableViewCell(), forRowAt: IndexPath(row: 0, section: 0))

        // Then
        XCTAssertEqual(viewModel.didWillDisplayIndex, 0)
    }
    
    class MockNFTListViewModel: NFTListViewModeling {
        
        var context: DinzWeb3.NFTListContext
        
        var reloadTablePublisher: AnyPublisher<Bool, Never> { Empty().eraseToAnyPublisher() }
        var errorPublisher: AnyPublisher<DinzWeb3.Model.ApiError, Never> { Empty().eraseToAnyPublisher() }
        var loadStatus: AnyPublisher<DinzWeb3.LoadStatus, Never> { Just(.none).eraseToAnyPublisher() }

        init(context: DinzWeb3.NFTListContext) {
            self.context = context
        }
        
        var dataSource: [NFTListCellType] = []
        
        var didCallRouteToNFTDetails = false
        var didWillDisplayIndex: Int?
        
        var didCallOnViewDidLoad = false

        func onViewDidLoad() {
            didCallOnViewDidLoad = true
        }

        func routeToNFTDetails(nft: Model.NFTModel) {
            didCallRouteToNFTDetails = true
        }
        
        func willDisplay(at index: Int) {
            didWillDisplayIndex = index
        }
        
        func loadNFTs() {
        }
    }
}


