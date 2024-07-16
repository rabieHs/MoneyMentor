//
//  LogFormViewModel.swift
//  MoneyMentor
//
//  Created by rabie houssaini on 16/7/2024.
//

import Foundation
import Observation
@Observable
class LogFormViewModel {
    var logToEdit: ExpenseLog?
    let db = DatabaseManager.shared
    var name = ""
    var amount : Double = 0
    var category = Category.utilities
    var date = Date()
    
    var isSaeButtonDesabled: Bool {
        name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    let numberFormatter : NumberFormatter =  {
        let formatter = NumberFormatter()
        formatter.isLenient = true
        formatter.numberStyle = .currency
        formatter.currencyCode = "USD"
        return formatter

        
    }()
    
    init(logToEdit: ExpenseLog? = nil) {
        self.logToEdit = logToEdit
        if let logToEdit {
            name = logToEdit.name
            amount = logToEdit.amount
            category = logToEdit.categoryEnum
            date = logToEdit.date
            numberFormatter.currencyCode = logToEdit.currency
            
            
        }
        
        func save(){
            var log: ExpenseLog
            if let logToEdit {
                log = logToEdit
            }else{
                log = ExpenseLog(id: UUID().uuidString, name: "", amount: 0, category: "", date: .now)
            }
            log.name = name.trimmingCharacters(in: .whitespacesAndNewlines)
            log.category = category.rawValue
            log.amount = amount
            log.date = date
            
            if self.logToEdit == nil {
                try? db.add(log: log)
            }else{
                db.update(log: log)
            }
            
        }
        
        func delete(log: ExpenseLog){
            db.delete(log: log)
        }
    }
    
}
