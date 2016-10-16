//
//  MathematicsTest.swift
//  DomainModelingPart2
//
//  Created by cmfeng on 10/15/16.
//  Copyright © 2016 cmfeng. All rights reserved.
//

import XCTest

import DomainModelingPart2


class MathematicsTests: XCTestCase {
    
    let tenUSD = Money(amount: 10, currency: "USD")
    let twelveUSD = Money(amount: 12, currency: "USD")
    let fiveGBP = Money(amount: 5, currency: "GBP")
    let fifteenEUR = Money(amount: 15, currency: "EUR")
    let fifteenCAN = Money(amount: 15, currency: "CAN")
    
    func testMoney() {
        let total = tenUSD + twelveUSD
        XCTAssert(total.amount == 22)
        XCTAssert(total.currency == "USD")
    }
    
    func testAddUSDtoGBP() {
        let total = tenUSD + fiveGBP
        XCTAssert(total.amount == 10)
        XCTAssert(total.currency == "GBP")
    }
    
    func testSubtractUSDfromGBP() {
        let total = tenUSD - fiveGBP
        XCTAssert(total.amount == 0)
        XCTAssert(total.currency == "GBP")
    }

}
