//
//  DoubleExtensionTest.swift
//  DomainModelingPart2
//
//  Created by cmfeng on 10/15/16.
//  Copyright © 2016 cmfeng. All rights reserved.
//

import XCTest

import ExtDomainModel

class DoubleExtensionTest {
    let tenUSD = 10.0.USD
    let fifteenGBP = 15.0.GBP
    func testTenUSD() {
        XCTAssert(tenUSD.amount == 10)
        XCTAssert(tenUSD.currency == "USD")
    }
    func testFifteenGBP(){
        XCTAssert(fifteenGBP.amount == 15)
        XCTAssert(fifteenGBP.currency == "GBP")
    }
}
