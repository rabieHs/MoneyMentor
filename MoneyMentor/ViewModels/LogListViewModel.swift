//
//  LogListViewModel.swift
//  MoneyMentor
//
//  Created by rabie houssaini on 16/7/2024.
//

import Foundation
import Observation
import FirebaseFirestore

@Observable
class LogListViewModel{
    let db = DatabaseManager.shared
    
    var sortType = SortType.date
    var sortOrder = SortOrder.descending
    var selectedCategories = Set<Category>()
    
    var isLogFormPresented = false
    var logToEdit: ExpenseLog?
    
    var predicates: [QueryPredicate]  {
        var predicates = [QueryPredicate]()
        if selectedCategories.count > 0 {
            predicates.append(.where("category", isIn: Array(selectedCategories).map({$0.rawValue})))
        }
        predicates.append(.order(by: sortType.rawValue,descending: sortOrder == .descending ))
        return predicates
    }
    
}
