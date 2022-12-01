//
//  ContentView.swift
//  CollegeMessanger
//
//  Created by Денис Большачков on 29.10.2022.
//

import SwiftUI

struct ContentView: View {
//    @State private var selectedTab: TabType = .main

    var body: some View {
        AuthView()
        
//        TabView(selection: $selectedTab) {
//            main.tag(TabType.main)
//        }
    }
    
//    private var main: some View {
//        MainView()
//            .tabItem {
//                Label("", systemImage: "house")
//            }
//    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

enum TabType: Int {
    case main
}
