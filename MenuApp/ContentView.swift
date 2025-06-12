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
                            ItemRow(item: item)
                        }
                    }
                }
            }
            .navigationTitle("Menu")
        }
    }
}

struct ItemRow: View {
    var item: MenuItem
    
    var body: some View {
        HStack {
            Image(item.thumbnailImage)
            
            VStack(alignment: .leading) {
                Text(item.name)
                Text("\(item.price, format: .currency(code: "TRY"))")
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .border(.green)
    }
}

#Preview("Main") {
    ContentView()
}

#Preview("ItemRow") {
    ItemRow(item: MenuItem.example)
}
