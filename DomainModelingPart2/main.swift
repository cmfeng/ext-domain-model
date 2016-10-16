//
//  main.swift
//  DomainModelingPart2
//
//  Created by cmfeng on 10/15/16.
//  Copyright © 2016 cmfeng. All rights reserved.
//

import Foundation

public func testMe() -> String {
    return "I have been tested"
}

open class TestMe {
    open func Please() -> String {
        return "I have been tested"
    }
}

public protocol CustomStringConvertible{
    var description : String{
        get
    }
}

public protocol Mathematics{
    static func +(lhs: Self, rhs: Self) -> (Self)
    static func -(lhs: Self, rhs: Self) -> (Self)
}
////////////////////////////////////
// Money
//
public struct Money : CustomStringConvertible, Mathematics{
    public var currency : String
    public var amount : Int
    init (amount: Int, currency: String) {
        self.currency = currency
        self.amount = amount
    }
    public var description : String{
        get{return "\(currency)\(amount)"}
    }
    public var dic: [String: Int] = ["USD" : 15, "GBP" : 30,
                                     "EUR" : 10, "CAN" : 12]
    
    
    public func convert(_ to: String) -> Money {
        let ratio = (Double(dic[self.currency]!)) / (Double (dic[to]!))
        let new = Int((Double(self.amount)) * ratio)
        return Money(amount: new, currency: to)
    }
    
    public func add(_ to: Money) -> Money {
        let m = self.convert("USD")
        let n = to.convert("USD")
        let total = Money(amount: m.amount + n.amount, currency: "USD")
        return total.convert(to.currency)
    }
    public func subtract(_ from: Money) -> Money {
        let m = self.convert("USD")
        let n = from.convert("USD")
        let result = Money(amount: n.amount - m.amount, currency: "USD")
        return result.convert(from.currency)
    }
    static public func +(lhs: Money, rhs: Money) -> (Money){
        return lhs.add(rhs)
    }
    static public func -(lhs: Money, rhs: Money) -> (Money){
        return lhs.subtract(rhs)
    }
}

////////////////////////////////////
// Job
//
open class Job : CustomStringConvertible{
    fileprivate var title : String
    fileprivate var type : JobType
    
    public enum JobType {
        case Hourly(Double)
        case Salary(Int)
    }
    
    public init(title : String, type : JobType) {
        self.title = title
        self.type = type
    }
    public var description : String{
        get {
            var t : String
            switch type{
            case .Hourly(let h):
                t = "Hourly\(h)"
            case .Salary(let s):
                t = "Salary\(s)"
            }
            return "\(title)\(t)"
        }
    }
    
    open func calculateIncome(_ hours: Int) -> Int {
        switch self.type{
        case .Hourly(let h):
            return (Int(Double(hours) * h))
        case.Salary(let y):
            return y
        }
    }
    
    open func raise(_ amt : Double) {
        switch self.type{
        case .Hourly(let h):
            self.type = .Hourly(h + amt)
        case .Salary(let y):
            self.type = .Salary(y + Int(amt))
        }
    }
}

////////////////////////////////////
// Person

open class Person : CustomStringConvertible{
    open var firstName : String = ""
    open var lastName : String = ""
    open var age : Int = 0
    
    fileprivate var _job : Job? = nil
    open var job : Job? {
        get {
            if _job == nil{
                return nil
            }else {
                return _job!
            }
        }
        set(value) {
            if age < 16{
                _job = nil
            } else {
                _job = value
            }
        }
    }
    
    fileprivate var _spouse : Person? = nil
    open var spouse : Person? {
        get {
            if _spouse == nil {
                return nil
            }else {
                return _spouse
            }}
        set(value) {
            if age < 18 {
                _spouse = nil
            } else {
                _spouse = value
            }
        }
    }
    
    public init(firstName : String, lastName: String, age : Int) {
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
    }
    
    open func toString() -> String {
        return "[Person: firstName:\(self.firstName) lastName:\(self.lastName) age:\(self.age) job:nil spouse:nil]"
    }
    public var description : String{
        get{
            var spouseDescription : String?
            /*var jobDesc: String? = nil
            if self.job != nil{
                jobDesc = self.job!.description
            }*/
            if self.spouse != nil {
                spouseDescription = "firstName:\(self.spouse!.firstName) lastName:\(self.spouse!.lastName)"
                return "Person: firstName:\(self.firstName) lastName:\(self.lastName) age:\(self.age) job:\(self.job?.description) spouse:\(spouseDescription!)"} else {
                return "Person: firstName:\(self.firstName) lastName:\(self.lastName) age:\(self.age) job:\(self.job?.description) spouse:nil"}
    }
    }
}

////////////////////////////////////
// Family
//
open class Family : CustomStringConvertible{
    fileprivate var members : [Person] = []
    
    public init(spouse1: Person, spouse2: Person) {
        //if (spouse1.age >= 21 || spouse2.age >= 21){
        members.append(spouse1)
        members.append(spouse2)
        spouse1.spouse = spouse2
        spouse2.spouse = spouse1
        //}
    }
    
    open func haveChild(_ child: Person) -> Bool {
        //let child : Person = Person(firstName: "", lastName: "", age: 0)
        members.append(child)
        return true
    }
    
    open func householdIncome() -> Int {
        var total: Int = 0
        for p in members {
            if p.job != nil{
                switch (p.job!.type){
                case .Salary:
                    total += p.job!.calculateIncome(1)
                case .Hourly:
                    total += (p.job!.calculateIncome(2000))
                }
            }
            
        }
        return total
    }
    public var description : String{
        get{
            var s : String = "Family: "
            for p in members{
                s += p.description
            }
            return s
        }
    }
}
extension Double {
    var USD: Money{return Money(amount: Int(self), currency: "USD")}
    var EUR: Money{return Money(amount: Int(self), currency: "EUR")}
    var GBP: Money{return Money(amount: Int(self), currency: "GBP")}
    var YEN: Money{return Money(amount: Int(self), currency: "YEN")}
}
