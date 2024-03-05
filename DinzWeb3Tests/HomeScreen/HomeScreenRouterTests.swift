//
//  HomeScreenRouterTests.swift
//  DinzWeb3Tests
//
//  Created by Dino Bozic on 04.03.2024..
//

import XCTest
@testable import DinzWeb3
import Combine

class HomeScreenRouterTests: XCTestCase {
    
    var router: HomeScreenRouter!
    var viewController: MockHomeScreenViewController!
    
    override func setUp() {
        super.setUp()
        let mockViewModel = MockHomeScreenViewModel(context: .init())
        viewController = MockHomeScreenViewController(viewModel: mockViewModel)
        router = HomeScreenRouter()
        router.viewController = viewController
    }
    
    override func tearDown() {
        viewController = nil
        router = nil
        super.tearDown()
    }
    
    func testPresentAlert() {
        // Given
        let title = "Test Title"
        let message = "Test Message"
        
        // When
        router.presentAlert(title: title, message: message)
        
        // Then
        XCTAssertTrue(viewController.routedViewController is UIAlertController)
        let alertController = viewController.routedViewController as! UIAlertController
        XCTAssertEqual(alertController.title, title)
        XCTAssertEqual(alertController.message, message)
    }
    
    func testPresentNFTDetails() {
        // Given
        let nft = Model.NFTModel(contract: .init(address: ""))
        
        // When
        router.presentNFTDetails(nft: nft)
        
        // Then
        XCTAssertTrue(viewController.routedViewController is NFTDetailsViewController)
        let detailsViewController = viewController.routedViewController as! NFTDetailsViewController
        XCTAssertEqual(detailsViewController.viewModel.context.nft, nft)
    }
    
    func testPresentNFTList() {
        // When
        router.presentNFTList()
        
        // Then
        XCTAssertTrue(viewController.routedViewController is NFTListViewController)
    }
    
    func testPresentTransactionList() {
        // When
        router.presentTransactionList()
        
        // Then
        XCTAssertTrue(viewController.routedViewController is TransactionsListViewController<TransactionsListViewModel>)
    }
    
    class MockHomeScreenViewController: HomeScreenViewController {
        var routedViewController: UIViewController?
        
        override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
            routedViewController = viewControllerToPresent
        }
    }
    
    final class MockHomeScreenViewModel: HomeScreenViewModeling {
        
        var context: DinzWeb3.HomeScreenContext
        
        init(context: DinzWeb3.HomeScreenContext) {
            self.context = context
        }
        
        var ethBalance: AnyPublisher<DinzWeb3.Model.ETHBalanceModel, Never> { Just(.init(result: "")).eraseToAnyPublisher() }
        
        var nfts: AnyPublisher<DinzWeb3.Model.GetNFTsForOwnerResponse, Never> { Just(.init(ownedNfts: [], totalCount: 0)).eraseToAnyPublisher()}
        
        var tokenBalances: AnyPublisher<[DinzWeb3.Model.TokenBalance], Never> { Just([.init(contractAddress: "", tokenBalance: "")]).eraseToAnyPublisher()}
        
        var transactionCount: AnyPublisher<String, Never> { Just("").eraseToAnyPublisher()}
        
        var errorPublisher: AnyPublisher<DinzWeb3.Model.ApiError, Never> { Just(.init(code: .decodingError)).eraseToAnyPublisher()}
        
        var loadStatus: AnyPublisher<DinzWeb3.LoadStatus, Never> { Just(.none).eraseToAnyPublisher() }
        
        func routeToNFTDetails(nft: DinzWeb3.Model.NFTModel) {
        }
        
        func routeToNFTList() {
        }
        
        func routeToTransactionList() {
        }
        
        func onViewDidAppear() {
        }
        
        func getCache() {
        }
        
        func fetchETHBalance() {
        }
        
        func fetchWalletNFTs() {
        }
        
        func fetchTokenBalances() {
        }
        
        func fetchTransactionCount() {
        }
    }
}
