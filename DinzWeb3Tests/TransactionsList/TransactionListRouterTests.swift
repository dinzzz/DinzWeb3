//
//  TransactionListRouterTests.swift
//  DinzWeb3Tests
//
//  Created by Dino Bozic on 04.03.2024..
//

import XCTest
@testable import DinzWeb3
import Combine
import SwiftUI

class TransactionListRouterTests: XCTestCase {
    
    var router: TransactionsListRouter!
    var viewController: MockTransactionsListViewController!
    
    override func setUp() {
        super.setUp()
        router = TransactionsListRouter()
        viewController = MockTransactionsListViewController(viewModel: .init(context: .init(), router: router))
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
        let model = Model.AssetTransferModel(blockNum: "1")
        
        // When
        router.presentDetails(model: model)
        
        // Then
        XCTAssertTrue(viewController.routedViewController is UINavigationController)
    }
    
    final class MockTransactionsListViewController: TransactionsListViewController<TransactionsListViewModel> {
        var routedViewController: UIViewController?
        
        override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
            routedViewController = viewControllerToPresent
        }
    }
}
