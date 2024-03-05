//
//  HomeScreenViewControllerTests.swift
//  DinzWeb3Tests
//
//  Created by Dino Bozic on 04.03.2024..
//

import XCTest
@testable import DinzWeb3
import Combine

class HomeScreenViewControllerTests: XCTestCase {
    
    var viewController: HomeScreenViewController!
    var viewModel: MockHomeScreenViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = MockHomeScreenViewModel(context: .init())
        viewController = HomeScreenViewController(viewModel: viewModel)
        viewController.loadViewIfNeeded()
    }
    
    override func tearDown() {
        viewController = nil
        viewModel = nil
        super.tearDown()
    }
    
    func testModalPresentationStyle() {
        XCTAssertEqual(viewController.modalPresentationStyle, .fullScreen)
    }
    
    func testBackgroundColor() {
        XCTAssertEqual(viewController.view.backgroundColor, UIStyle.Color.Background.primary)
    }
    
    func testAddSubviews() {
        XCTAssertEqual(viewController.view.subviews.count, 1) // Only the contentView should be added
        XCTAssertNotNil(viewController.view.subviews.first { $0 is HomeScreenContentView })
    }
    
    func testViewDidAppear() {
        viewController.viewDidAppear(false)
        XCTAssertTrue(viewModel.onViewDidAppearCalled)
    }
    
    func testDidTapNFT() {
        // Given
        let nftModel = Model.NFTModel(contract: .init(address: ""))
        
        // When
        viewController.didTapNFT(nftModel)
        
        // Then
        XCTAssertTrue(viewModel.didCallRouteToNFT)
        XCTAssertEqual(nftModel, viewModel.nftToShow)
    }

    func testDidTapViewAllNFTs() {
        // When
        viewController.didTapViewAllNFTs()
        
        // Then
        XCTAssertTrue(viewModel.didCallRouteToNFTList)
    }

    func testDidTapIncomingTransactions() {
        // When
        viewController.didTapIncomingTransactions()
        
        // Then
        XCTAssertTrue(viewModel.didCallRouteToTransactionsList)
    }
    
    final class MockHomeScreenViewModel: HomeScreenViewModeling {
        var context: DinzWeb3.HomeScreenContext
        
        var onViewDidAppearCalled = false
        
        var didCallRouteToNFT = false
        var nftToShow: Model.NFTModel?
        
        var didCallRouteToTransactionsList = false
        var didCallRouteToNFTList = false
        
        func onViewDidAppear() {
            onViewDidAppearCalled = true
        }
        
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
            didCallRouteToNFT = true
            nftToShow = nft
        }
        
        func routeToNFTList() {
            didCallRouteToNFTList = true
        }
        
        func routeToTransactionList() {
            didCallRouteToTransactionsList = true
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
