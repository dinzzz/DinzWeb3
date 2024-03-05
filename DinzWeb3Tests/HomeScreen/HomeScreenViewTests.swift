//
//  HomeScreenViewTests.swift
//  DinzWeb3Tests
//
//  Created by Dino Bozic on 04.03.2024..
//

import XCTest
@testable import DinzWeb3
import Combine

class HomeScreenContentViewTests: XCTestCase {
    
    var sut: HomeScreenContentView!
    
    override func setUp() {
        super.setUp()
        sut = HomeScreenContentView()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testDelegateIsSet() {
        // Given
        let mockDelegate = MockScreenContentViewDelegate()
        
        // When
        sut.delegate(to: mockDelegate)
        
        // Then
        XCTAssertNotNil(sut.delegate)
    }
    
    func testDidTapIncomingTransactions() {
        // Given
        let mockDelegate = MockScreenContentViewDelegate()
        sut.delegate(to: mockDelegate)
        
        // When
        sut.incomingTransactionsButton.sendActions(for: .touchUpInside)
        
        // Then
        XCTAssertTrue(mockDelegate.didTapIncomingTransactionsCalled)
    }

    func testDidTapIncomingTransactions_NotSet() {
        // Given
        let mockDelegate = MockScreenContentViewDelegate()
        sut.delegate(to: mockDelegate)
        
        // When
        sut.delegate = nil
        sut.incomingTransactionsButton.sendActions(for: .touchUpInside)
        
        // Then
        XCTAssertFalse(mockDelegate.didTapIncomingTransactionsCalled)
    }
    
    class MockScreenContentViewDelegate: HomeScreenContentViewDelegate {
        var didTapIncomingTransactionsCalled = false
        
        func didTapIncomingTransactions() {
            didTapIncomingTransactionsCalled = true
        }
    }
}
