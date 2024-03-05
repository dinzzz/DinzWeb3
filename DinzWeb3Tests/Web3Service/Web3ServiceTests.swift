//
//  Web3ServiceTests.swift
//  DinzWeb3Tests
//
//  Created by Dino Bozic on 04.03.2024..
//

import XCTest
@testable import DinzWeb3
import Combine

class Web3ServiceTests: XCTestCase {

    func testConvertToDouble() {
        // Normal hex value
        let hexValueNormal = "0x123456"
        XCTAssertEqual(Web3Service.convertToDouble(hexValue: hexValueNormal), 1193046 / 1e18)
        
        // Hex value with letters
        let hexValueLetters = "0xABCDEF"
        XCTAssertEqual(Web3Service.convertToDouble(hexValue: hexValueLetters), 11259375 / 1e18)
        
        // Hex value with all zeros
        let hexValueAllZeros = "0x0"
        XCTAssertEqual(Web3Service.convertToDouble(hexValue: hexValueAllZeros), 0.0)
        
        // Invalid hex value (should return nil)
        let hexValueInvalid = "xyz"
        XCTAssertNil(Web3Service.convertToDouble(hexValue: hexValueInvalid))
    }
    
    func testConvertToInt() {
        // Normal hex value
        let hexValueNormal = "0x123456"
        XCTAssertEqual(Web3Service.convertToInt(hexValue: hexValueNormal), 1193046)
        
        // Hex value with letters
        let hexValueLetters = "0xABCDEF"
        XCTAssertEqual(Web3Service.convertToInt(hexValue: hexValueLetters), 11259375)
        
        // Hex value with all zeros
        let hexValueAllZeros = "0x0"
        XCTAssertEqual(Web3Service.convertToInt(hexValue: hexValueAllZeros), 0)
        
        // Invalid hex value (should return nil)
        let hexValueInvalid = "xyz"
        XCTAssertNil(Web3Service.convertToInt(hexValue: hexValueInvalid))
    }
}
