//
//  NFTListRouterTests.swift
//  DinzWeb3Tests
//
//  Created by Dino Bozic on 04.03.2024..
//

import XCTest
@testable import DinzWeb3
import Combine

class NFTListRouterTests: XCTestCase {
    
    var router: NFTListRouter!
    var viewController: MockNFTListViewController!
    
    override func setUp() {
        super.setUp()
        router = NFTListRouter()
        viewController = MockNFTListViewController(viewModel: MockNFTListViewModel(context: .init(address: "")))
        router.viewController = viewController
    }
    
    override func tearDown() {
        router = nil
        viewController = nil
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
    
    final class MockNFTListViewController: NFTListViewController {
        var routedViewController: UIViewController?
        
        override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
            routedViewController = viewControllerToPresent
        }
    }
    
    final class MockNFTListViewModel: NFTListViewModeling {
        
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
