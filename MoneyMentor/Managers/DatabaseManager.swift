//
//  DatabaseManager.swift
//  MoneyMentor
//
//  Created by rabie houssaini on 16/7/2024.
//

import Foundation
import FirebaseFirestore
class DatabaseManager{
    static let shared = DatabaseManager()
    
    private init(){}
    
    private(set) lazy var logsCollection:CollectionReference = {
        Firestore.firestore().collection("logs")
    }()
    
    func add(log: ExpenseLog)throws{
        try logsCollection.document(log.id).setData(from: log)
    }
    func update(log: ExpenseLog){
        logsCollection.document(log.id).updateData(log.asDectionary())
    }
    func delete(log: ExpenseLog){
        logsCollection.document(log.id).delete()
    }
}
