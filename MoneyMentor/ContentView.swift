//
//  ContentView.swift
//  MoneyMentor
//
//  Created by rabie houssaini on 16/7/2024.
//

import SwiftUI

struct ContentView: View {
    @State var vm = LogListViewModel()
    @Environment(\.horizontalSizeClass) var horizontalSizeCalss
    
    var body: some View {
        #if os(macOs)
        splitView
        #elseif os(visionOS)
        tabView
        #else
        switch horizontalSizeCalss{
        case .compact:
            tabView
        default:
            splitView
        }
        #endif
    }
    
    var tabView: some View{
        TabView {
            NavigationStack{
                LogLitContainerView(vm: $vm)
            }
            .tabItem { Label("Expenes", systemImage: "tray") }
            
            NavigationStack{
                Text("Ai Assistant space")
            }
            .tabItem { Label("AI Assistant", systemImage: "waveform") }

        }
        
    }
    
    var splitView : some View{
        NavigationSplitView{
            List{
                NavigationLink {
                    LogLitContainerView(vm: $vm)
                } label: {
                    Label("Expenses", systemImage: "tray")
                }
                NavigationLink {
                    Text("AI Assistant space")
                } label: {
                    Label("AI Assistant", systemImage: "waveform")
                }
            }

        }detail: {
            LogLitContainerView(vm: $vm)
                
        }
        .navigationTitle("MoneyMentor")
    }
}

#Preview {
    ContentView()
}
