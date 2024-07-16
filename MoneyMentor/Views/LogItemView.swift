//
//  LogItemView.swift
//  MoneyMentor
//
//  Created by rabie houssaini on 16/7/2024.
//

import SwiftUI

struct LogItemView: View {
    let log: ExpenseLog
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    var body: some View {
        switch horizontalSizeClass{
        case .compact : compactView
        default: regularView
        }
    }
    
    var compactView: some View{
        HStack(spacing:16){
            CategoryImageView(category: log.categoryEnum)
            VStack(alignment:.leading){
                Text(log.name).font(.headline)
                Text(log.dateText).font(.subheadline)
            }
            Spacer()
            Text(log.amountText).font(.headline)
        }
    }
    
    var regularView: some View{
        HStack(spacing:16){
            CategoryImageView(category: log.categoryEnum)
            Spacer()
            Text(log.name)
                .frame(minWidth: 0,maxWidth: .infinity,alignment: .leading)
            Spacer()
            Text(log.amountText)
                .frame(minWidth: 0,maxWidth: .infinity,alignment: .leading)
            Spacer()
            Text(log.dateText)
                .frame(minWidth: 0,maxWidth: .infinity,alignment: .leading)
            Spacer()
            Text(log.categoryEnum.rawValue)
            Spacer()
            
        }
    }
    
}

#Preview {
    VStack{
        ForEach([ExpenseLog(id: "1", name: "sishi", amount: 10, category: "Food", date: .now),ExpenseLog(id: "2", name: "Electricity", amount: 50, category: "Utilities", date: .now)]){log in
            LogItemView(log: log)
        }
    }.padding()
}
