//
//  NFTListViewModelTests.swift
//  DinzWeb3Tests
//
//  Created by Dino Bozic on 04.03.2024..
//

import XCTest
@testable import DinzWeb3
import Combine

final class NFTListViewModelTests: XCTestCase {
    
    private var viewModel: NFTListViewModel!
    private var errorViewModel: NFTListViewModel!
    
    private var cancellables = Set<AnyCancellable>()

    override func setUpWithError() throws {
        let mockRouter = MockNFTListRouter()
        let mockWeb3Service = MockWeb3Service()
        
        self.viewModel = NFTListViewModel(context: .init(address: ""), router: mockRouter, web3Service: mockWeb3Service)
        
        let mockErrorWeb3Service = MockWeb3Service()
        mockErrorWeb3Service.getOwnedNFTsResult = Fail(error: DinzWeb3.Model.ApiError.init(code: .decodingError)).eraseToAnyPublisher()
        self.errorViewModel = NFTListViewModel(context: .init(address: ""), router: mockRouter, web3Service: mockErrorWeb3Service)
    }
    
    func testViewDidLoad() {
        let expectedOwnedNFTS: [Model.NFTModel] = [.init(contract: .init(address: "nft1Address")), .init(contract: .init(address: "nft2Address"))]
        let expectedTotalCount = 2
        
        let expectation = XCTestExpectation(description: "Performing async operation")
        
        var receivedNFTs: [Model.NFTModel]?
        var receivedCount: Int?
        
        viewModel.reloadTablePublisher.sink { _ in
            receivedCount  = self.viewModel.dataSource.count
            receivedNFTs = self.viewModel.dataSource.compactMap {
                switch $0 {
                case .nft(let model):
                    return model.nft
                }
            }
            expectation.fulfill()
        }.store(in: &cancellables)
        
        viewModel.onViewDidLoad()
        
        wait(for: [expectation], timeout: 2)
        
        XCTAssertEqual(expectedOwnedNFTS, receivedNFTs)
        XCTAssertEqual(expectedTotalCount, receivedCount)
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
    
    final class MockNFTListRouter: NFTListRouting {
        var viewController: DinzWeb3.NFTListViewController?
        
        var didCallPresentAlert = false
        var didCallPresentNFTDetails = false
        
        func presentNFTDetails(nft: DinzWeb3.Model.NFTModel) {
            didCallPresentAlert = true
        }
        
        func presentAlert(title: String, message: String) {
            didCallPresentNFTDetails = true
        }
    }
}
