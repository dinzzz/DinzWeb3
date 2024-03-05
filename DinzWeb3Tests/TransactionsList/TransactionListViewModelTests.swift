//
//  TransactionListViewModelTests.swift
//  DinzWeb3Tests
//
//  Created by Dino Bozic on 04.03.2024..
//

import XCTest
@testable import DinzWeb3
import Combine

final class TransactionListViewModelTests: XCTestCase {
    
    private var viewModel: TransactionsListViewModel!
    private var errorViewModel: TransactionsListViewModel!
    
    private var cancellables = Set<AnyCancellable>()

    override func setUpWithError() throws {
        let mockRouter = MockTransactionsListRouter()
        let mockWeb3Service = MockWeb3Service()
        
        self.viewModel = TransactionsListViewModel(context: .init(), router: mockRouter, web3Service: mockWeb3Service)
        
        let mockErrorWeb3Service = MockWeb3Service()
        mockErrorWeb3Service.getToAssetResult = Fail(error: DinzWeb3.Model.ApiError.init(code: .decodingError)).eraseToAnyPublisher()
        self.errorViewModel = TransactionsListViewModel(context: .init(), router: mockRouter, web3Service: mockErrorWeb3Service)
    }
    
    func testViewDidLoad() {
        let expectedTransfers = [Model.AssetTransferModel(from: "From address1", to: "To address2"), Model.AssetTransferModel(from: "From address2", to: "To address1")]
        
        let expectation = XCTestExpectation(description: "Performing async operation")
        
        viewModel.loadTransactions()
        
        wait()
        
        var receivedTransfers = viewModel.transfers
        
        XCTAssertEqual(expectedTransfers, receivedTransfers)
    }
    
    private func wait() {
        let exp = expectation(description: "Wait for async")
        _ = XCTWaiter.wait(for: [exp], timeout: 1.0)
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
        
        errorViewModel.onViewDidLoad()

        wait(for: [expectation], timeout: 2)
        
        XCTAssertEqual(expectedError, receivedError)
    }
    
    final class MockTransactionsListRouter: TransactionsListRouting {
        var viewController: DinzWeb3.TransactionsListViewController<DinzWeb3.TransactionsListViewModel>?
        
        var didCallPresentAlert = false
        var didCallPresentDetails = false
        
        func presentDetails(model: DinzWeb3.Model.AssetTransferModel) {
            didCallPresentDetails = true
        }
        
        func presentAlert(title: String, message: String) {
            didCallPresentAlert = true
        }
        
        typealias ViewModel = TransactionsListViewModel
    }
}
