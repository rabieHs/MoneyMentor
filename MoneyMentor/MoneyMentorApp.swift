//
//  MoneyMentorApp.swift
//  MoneyMentor
//
//  Created by rabie houssaini on 16/7/2024.
//

import SwiftUI
import Firebase

@main
struct MoneyMentorApp: App {
    #if os(macOS)
    @NSApplicationDelegateAdaptor private var appDelegate: AppDelegate
    #else
    @UIApplicationDelegateAdaptor private var appDelegate: AppDelegate
    #endif
    
    var body: some Scene {
        WindowGroup {
            ContentView()
            #if os(macOS)
                .frame(minWidth: 729,minHeight: 480)
            #endif
        }
            #if os(macOS)
        .windowResizability(.contentSize)
            #endif
        
    }
}
