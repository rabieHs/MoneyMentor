//
//  ExpenseLog.swift
//  MoneyMentor
//
//  Created by rabie houssaini on 16/7/2024.
//

import Foundation

struct ExpenseLog: Codable, Identifiable, Equatable{
    let id:String
    var name: String
    var amount: Double
    var category: String
    var currency: String
    var date: Date
    
    var categoryEnum:Category{
        Category(rawValue: category) ?? .utilities
    }
    init(id: String, name: String, amount: Double, category: String, currency: String = "USD", date: Date) {
        self.id = id
        self.name = name
        self.amount = amount
        self.category = category
        self.currency = currency
        self.date = date
    }
}
