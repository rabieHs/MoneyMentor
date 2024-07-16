//
//  Extensions.swift
//  MoneyMentor
//
//  Created by rabie houssaini on 16/7/2024.
//

import Foundation
extension ExpenseLog {
    var dateText: String{
        Utils.dateFormatter.string(from: date)
    }
    var amountText: String {
        Utils.numberFormatter.currencySymbol = currency
      return  Utils.numberFormatter.string(from: NSNumber(value: amount)) ?? "\(amount)"
    }
}

extension Encodable{
    func asDectionary()->[String: Any]{
        guard let data = try? JSONEncoder().encode(self) else {return [:]}
        do {
            let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
            return json ?? [:]
            
        }catch{
            return [:]
        }
    }
}
