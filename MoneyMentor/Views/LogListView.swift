//
//  LogListView.swift
//  MoneyMentor
//
//  Created by rabie houssaini on 16/7/2024.
//

import SwiftUI
import FirebaseFirestore

struct LogListView: View {
    @Binding var vm: LogListViewModel
    @FirestoreQuery(collectionPath: "logs",predicates: [.order(by: SortType.date.rawValue,descending: true)]) private var logs: [ExpenseLog]
    var body: some View {
        listView
            .listStyle(.plain)
            
            .sheet(item: $vm.logToEdit) {
                vm.logToEdit = nil
            } content: { log in
                LogFormView(vm: .init(logToEdit: log))
            }
            .overlay{
              if  logs.isEmpty {
                    Text("No expenses data\nPlease add your expenses using the add button ")
                      .multilineTextAlignment(.center)
                      .font(.headline)
                      .padding(.horizontal)
                }
            }
            .onChange(of: vm.sortType) {
                updateFirestoreQuery()
            }
            .onChange(of: vm.sortOrder) {
                updateFirestoreQuery()
            }
            .onChange(of: vm.selectedCategories) {
                updateFirestoreQuery()
            }

    }
    
    var listView: some View{
        #if os(iOS)
        List{
            ForEach(logs){log in
                LogItemView(log: log )
                    .contentShape(Rectangle())
                    .onTapGesture {
                        vm.logToEdit = log
                    }
                    .padding(.vertical,4)
            }
            .onDelete(perform: onDelete)
            
        }
        #else
        ZStack{
            ScrollView{
                ForEach(logs){log in
                    VStack{
                        LogItemView(log: log)
                        Divider()
                    }
                    .frame(minWidth: 0,maxWidth: .infinity,alignment: .leading)
                    .contentShape(Rectangle())
                    .padding(.horizontal)
                    .onTapGesture{
                        vm.logToEdit = log
                    }
                    .contextMenu(ContextMenu(menuItems: {
                        Button("Edit"){
                            vm.logToEdit = log

                        }
                        Button("Delete"){
                            vm.db.delete(log: log)

                        }
                        
                        
                    }))
                }
            }.contentMargins(.vertical,8, for: .scrollContent)
        }
        #endif
    }
    
    func updateFirestoreQuery(){
        $logs.predicates =  vm.predicates
    }
    
    private func onDelete(with indexSet: IndexSet){
        indexSet.forEach { index in
            let log = logs[index]
            vm.db.delete(log: log)
        }
    }
}

#Preview {
    LogListView(vm: .constant(LogListViewModel()))
    #if os(macOS)
        .frame(width:500)
    #endif
}
