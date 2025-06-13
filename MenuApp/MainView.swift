//
//  MainView.swift
//  MenuApp
//
//  Created by emre argana on 14.06.2025.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            ContentView()
                .tabItem {
                    Label("Menu", systemImage: "list.dash")
                }
            OrderView()
                .tabItem {
                    Label("Order", systemImage: "cart")
                }
        }
    }
}

#Preview {
    MainView()
}
