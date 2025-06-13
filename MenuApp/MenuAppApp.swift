//
//  MenuAppApp.swift
//  MenuApp
//
//  Created by emre argana on 12.06.2025.
//

import SwiftUI

@main
struct MenuAppApp: App {
    @StateObject var order = Order()

    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(order)
        }
    }
}
