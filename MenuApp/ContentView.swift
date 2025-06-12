import SwiftUI
import Foundation

struct ContentView: View {
    let menu = Bundle.main.decode([MenuSection].self, from: "menu.json")

    var body: some View {
        NavigationView {
            List {
                ForEach(menu, id: \.id) { section in
                    Section(header: Text(section.name)) {
                        ForEach(section.items, id: \.id) { item in
                            Text(item.name)
                        }
                    }
                }
            }
            .listStyle(.grouped)
            .navigationTitle("Menu")
        }
    }
}
