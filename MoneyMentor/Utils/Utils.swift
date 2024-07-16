//
//  Utils.swift
//  MoneyMentor
//
//  Created by rabie houssaini on 16/7/2024.
//

import Foundation

struct Utils{
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM"
        return formatter
    }()
    
    static let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.isLenient = true
        formatter.numberStyle = .currency
        return formatter
    }()
}
