//
//  HomeScreenViewModelTests.swift
//  DinzWeb3Tests
//
//  Created by Dino Bozic on 04.03.2024..
//

import XCTest
@testable import DinzWeb3
import Combine

final class HomeScreenViewModelTests: XCTestCase {
    
    private var viewModel: HomeScreenViewModel!
    private var errorViewModel: HomeScreenViewModel!
    
    private var cancellables = Set<AnyCancellable>()

    override func setUpWithError() throws {
        let mockRouter = MockHomeScreenRouter()
        let mockWeb3Service = MockWeb3Service()
        
        self.viewModel = HomeScreenViewModel(context: .init(), router: mockRouter, web3Service: mockWeb3Service)
        
        let mockErrorWeb3Service = MockWeb3Service()
        mockErrorWeb3Service.getETHBalanceResult = Fail(error: DinzWeb3.Model.ApiError.init(code: .decodingError)).eraseToAnyPublisher()
        self.errorViewModel = HomeScreenViewModel(context: .init(), router: mockRouter, web3Service: mockErrorWeb3Service)
    }
    
    func testViewDidAppear() {
        let expectedBalance = "ETHBalanceResult"
        let expectedTransactionsCount = 25
        
        let expectation = XCTestExpectation(description: "Performing async operation")
        
        var receivedBalance: String?
        var receivedCount: Int?
        
        Publishers.CombineLatest(viewModel.ethBalance, viewModel.transactionCount).sink { ethBalance, transactionsCount in
            receivedBalance = ethBalance.result
            receivedCount  = Int(transactionsCount)
            expectation.fulfill()
        }.store(in: &cancellables)
        
        viewModel.onViewDidAppear()
        
        wait(for: [expectation], timeout: 2)
        
        XCTAssertEqual(expectedBalance, receivedBalance)
        XCTAssertEqual(expectedTransactionsCount, receivedCount)
    }
    
    func testViewDidAppearWithError() {
        // Should present alert and error
        let expectedError = DinzWeb3.Model.ApiError.init(code: .decodingError)
        
        let expectation = XCTestExpectation(description: "Performing async operation")
        
        var receivedError: DinzWeb3.Model.ApiError?
        errorViewModel.errorPublisher.sink(receiveValue: { errorValue in
            receivedError = errorValue
            expectation.fulfill()
        }).store(in: &cancellables)
        
        errorViewModel.onViewDidAppear()

        wait(for: [expectation], timeout: 2)
        
        XCTAssertEqual(expectedError, receivedError)
    }
    
    func testGetETHBalance() {
        let expectedBalance = "ETHBalanceResult"
        
        let expectation = XCTestExpectation(description: "Performing async operation")
        
        var receivedBalance: String?
        
        viewModel.ethBalance.sink { ethBalance in
            receivedBalance = ethBalance.result
            expectation.fulfill()
        }.store(in: &cancellables)
        
        viewModel.fetchETHBalance()
        
        wait(for: [expectation], timeout: 2)
        
        XCTAssertEqual(expectedBalance, receivedBalance)
    }
    
    func testGetOwnedNFTs() {
        let expectedOwnedNfts: [Model.NFTModel] = [.init(contract: .init(address: "nft1Address")), .init(contract: .init(address: "nft2Address"))]
        let expectedOwnedNftsCount = 2
        
        let expectation = XCTestExpectation(description: "Performing async operation")
        
        var receivedResponse: Model.GetNFTsForOwnerResponse?
        
        viewModel.nfts.sink { nftResult in
            receivedResponse = nftResult
            expectation.fulfill()
        }.store(in: &cancellables)
        
        viewModel.fetchWalletNFTs()
        
        wait(for: [expectation], timeout: 2)
        
        XCTAssertEqual(receivedResponse?.totalCount, expectedOwnedNftsCount)
        XCTAssertEqual(receivedResponse?.ownedNfts, expectedOwnedNfts)
    }
    
    func testGetTransactionsCount() {
        let expectedCount = 25
        
        let expectation = XCTestExpectation(description: "Performing async operation")
        
        var receivedCount: Int?
        
        viewModel.transactionCount.sink { count in
            receivedCount = Int(count)
            expectation.fulfill()
        }.store(in: &cancellables)
        
        viewModel.fetchTransactionCount()
        
        wait(for: [expectation], timeout: 2)
        
        XCTAssertEqual(expectedCount, receivedCount)
    }
    
    func testGetTokenBalances() {
        let expectedBalances = [Model.TokenBalance(contractAddress: "tokenBalanceAddress", tokenBalance: "tokenBalanceHex"), Model.TokenBalance(contractAddress: "tokenBalanceAddress", tokenBalance: "tokenBalanceHex")]
        
        let expectation = XCTestExpectation(description: "Performing async operation")
        
        var receivedBalances: [Model.TokenBalance]?
        
        viewModel.tokenBalances.sink { balances in
            receivedBalances = balances
            expectation.fulfill()
        }.store(in: &cancellables)
        
        viewModel.fetchTokenBalances()
        
        wait(for: [expectation], timeout: 2)
        
        XCTAssertEqual(expectedBalances, receivedBalances)
    }
    
    final class MockHomeScreenRouter: HomeScreenRouting {
        var viewController: DinzWeb3.HomeScreenViewController?
        
        var didCallPresentAlert = false
        var didCallPresentNFTDetails = false
        var didCallPresentNFTList = false
        var didCallPresentTransactionList = false
        
        func presentAlert(title: String, message: String) {
            didCallPresentAlert = true
        }
        
        func presentNFTDetails(nft: DinzWeb3.Model.NFTModel) {
            didCallPresentNFTDetails = true
        }
        
        func presentNFTList() {
            didCallPresentNFTList = true
        }
        
        func presentTransactionList() {
            didCallPresentTransactionList = true
        }
    }
}
