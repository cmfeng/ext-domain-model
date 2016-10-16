//
//  DescriptionTest.swift
//  DomainModelingPart2
//
//  Created by cmfeng on 10/15/16.
//  Copyright © 2016 cmfeng. All rights reserved.
//

import XCTest

import DomainModelingPart2


class MoneyTests: XCTestCase {
    
    let tenUSD = Money(amount: 10, currency: "USD")
    let twelveUSD = Money(amount: 12, currency: "USD")
    let fiveGBP = Money(amount: 5, currency: "GBP")
    let fifteenEUR = Money(amount: 15, currency: "EUR")
    let fifteenCAN = Money(amount: 15, currency: "CAN")
    
    func testCanICreateMoney() {
        let oneUSD = Money(amount: 1, currency: "USD")
        XCTAssert(oneUSD.amount == 1)
        XCTAssert(oneUSD.currency == "USD")
        
        let tenGBP = Money(amount: 10, currency: "GBP")
        XCTAssert(tenGBP.amount == 10)
        XCTAssert(tenGBP.currency == "GBP")
    }
    func testMoneyDesc(){
        let tenUSDDesc = tenUSD.description
        XCTAssert(tenUSDDesc == "USD10")
    }
    func testMoneyDesc2(){
        let fifteenEURDesc = fifteenEUR.description
        XCTAssert(fifteenEURDesc == "EUR15")
    }
}

class JobTests: XCTestCase {
    
    func testCreateSalaryJob() {
        let job = Job(title: "Guest Lecturer", type: Job.JobType.Salary(1000))
        XCTAssert(job.calculateIncome(50) == 1000)
        let desc = job.description
        XCTAssert(desc == "Guest LecturerSalary1000")
    }
    
    
    
    func testCreateHourlyJob() {
        let job = Job(title: "Janitor", type: Job.JobType.Hourly(15.0))
        XCTAssert(job.calculateIncome(10) == 150)
        let desc = job.description
        XCTAssert(desc == "JanitorHourly15.0")
    }
    
}

class PersonTests: XCTestCase {
    
    func testPerson() {
        let ted = Person(firstName: "Ted", lastName: "Neward", age: 45)
        XCTAssert(ted.description == "Person: firstName:Ted lastName:Neward age:45 job:nil spouse:nil")
        ted.spouse = Person(firstName: "Bambi", lastName: "Jones", age: 42)
        XCTAssert(ted.description == "Person: firstName:Ted lastName:Neward age:45 job:nil spouse:firstName:Bambi lastName:Jones")
    }
    
    
    
}

class FamilyTests : XCTestCase {
    
    func testFamily() {
        let ted = Person(firstName: "Ted", lastName: "Neward", age: 45)
        let charlotte = Person(firstName: "Charlotte", lastName: "Neward", age: 45)
        
        let family = Family(spouse1: ted, spouse2: charlotte)
        let mike = Person(firstName: "Mike", lastName: "Neward", age: 22)
        let _ = family.haveChild(mike)
        let familyDesc = family.description
        print ("MMM\(familyDesc)")
        XCTAssert(familyDesc == "Family: Person: firstName:Ted lastName:Neward age:45 job:nil spouse:firstName:Charlotte lastName:NewardPerson: firstName:Charlotte lastName:Neward age:45 job:nil spouse:firstName:Ted lastName:NewardPerson: firstName:Mike lastName:Neward age:22 job:nil spouse:nil")
    }
}


  
