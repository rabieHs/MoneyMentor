//
//  LogFormView.swift
//  MoneyMentor
//
//  Created by rabie houssaini on 16/7/2024.
//

import SwiftUI

struct LogFormView: View {
    @State var vm : LogFormViewModel
    @Environment(\.dismiss) var dissmiss
    #if !os(macOS)
    var title: String {
        ((vm.logToEdit == nil) ? "Create": "Edit") + " Expense Log"
    }
    var body: some View {
        NavigationStack{
            formView.toolbar{
                ToolbarItem( placement: .confirmationAction, content: {
                    Button("Save"){
                        self.onSave()
                    }.disabled(vm.isSaveButtonDesabled)
                })
                
                ToolbarItem( placement: .cancellationAction, content: {
                    Button("Cancel"){
                        self.onCancel()
                    }
                })
            }.navigationTitle(title)
                .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    #else
    
    var body: some View {
        VStack{
            formView.padding()
            HStack{
                Button("Cancel"){
                    self.onCancel()
                }
                Button("Save"){
                    self.onSave()
                }.buttonStyle(BorderedProminentButtonStyle())
                    .disabled($vm.isSaveButtonDesabled)
            }
            .padding()
        }
        .frame(minWidth: 300)
    }
    
    #endif
    
    private func onCancel(){
        dissmiss()
    }
    
    private func onSave(){
        #if !os(macOS)
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        #endif
        
        vm.save()
        dissmiss()
        
    }
    
    private var formView: some View {
        Form{
            TextField("Name", text: $vm.name)
                .autocorrectionDisabled()
            TextField("Amount", value: $vm.amount,formatter: vm.numberFormatter)
                .autocorrectionDisabled()
            #if !os(macOS)
                .keyboardType(.numbersAndPunctuation)
            
            #endif
            
            Picker(selection: $vm.category, content: {
                ForEach(Category.allCases){category in
                    Text(category.rawValue.capitalized).tag(category)
                }
            }, label: {Text("Category")})
            
            DatePicker(selection: $vm.date,displayedComponents: [.date, .hourAndMinute]) {
                Text("Date")
            }
            
        }
    }
        
    
}

#Preview {
    LogFormView(vm: LogFormViewModel())
}
