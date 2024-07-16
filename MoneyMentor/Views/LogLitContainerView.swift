//
//  LogLitContainerView.swift
//  MoneyMentor
//
//  Created by rabie houssaini on 16/7/2024.
//

import SwiftUI

struct LogLitContainerView: View {
    @Binding var vm: LogListViewModel
    var body: some View {
        VStack{
            FilterCategoriesView(selectedCategories: $vm.selectedCategories)
            Divider()
            SelectSortOrderView(sortType: $vm.sortType, sortOrder: $vm.sortOrder)
            Divider()
            LogListView(vm: $vm)
            #if !os(macOS)
                .navigationTitle("Money Mentor")
                .navigationBarTitleDisplayMode(.inline)
            #endif
        }
        .sheet(isPresented: $vm.isLogFormPresented, content: {
            LogFormView(vm: .init())
        })
        .toolbar(content: {
            ToolbarItem {
                Button(action: {vm.isLogFormPresented = true}, label: {
                    #if os(macOS)
                    HStack{
                        Image(systemName: "plus")
                            .symbolRenderingMode(.monochrome)
                            .tint(.accentColor)
                        Text("Add Expense Log")
                        
                    }
                    #else
                    Text("Add")
                    #endif
                })
            }
        })
    }
}

#Preview {
    NavigationStack{
        LogLitContainerView(vm: .constant(LogListViewModel()))
    }
}
