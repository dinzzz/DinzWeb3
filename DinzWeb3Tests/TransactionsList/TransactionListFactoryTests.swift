//
//  TransactionListFactoryTests.swift
//  DinzWeb3Tests
//
//  Created by Dino Bozic on 04.03.2024..
//

import XCTest
@testable import DinzWeb3
import Combine

class TransactionListFactoryTests: XCTestCase {

    func testViewControllerCreation() {
        // Given
        let factory = TransactionsListFactory()
        let context = TransactionsListContext()
        
        // When
        let viewController = factory.viewController(context: context)
        
        // Then
        XCTAssertNotNil(viewController)
    }
    
    func testPushMethod() {
        // Given
        let factory = TransactionsListFactory()
        let context = TransactionsListContext()
        let navigationController = UINavigationController()
        
        // When
        factory.push(on: navigationController, context: context)
        
        // Then
        XCTAssertEqual(navigationController.viewControllers.count, 1) // Check if viewController is pushed onto navigation stack
    }
    
    func testPresentMethod() {
        // Given
        let factory = TransactionsListFactory()
        let context = TransactionsListContext()
        let presentingViewController = UIViewController()
        
        let window = UIWindow()
        window.rootViewController = presentingViewController
        window.makeKeyAndVisible()
        
        // When
        factory.present(on: presentingViewController, context: context)
        
        // Then
        XCTAssertTrue(presentingViewController.presentedViewController is TransactionsListViewController<TransactionsListViewModel>)// Check if correct viewController is presented
    }
}
