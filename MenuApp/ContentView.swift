import SwiftUI
import Foundation

struct ContentView: View {
    let menu = Bundle.main.decode([MenuSection].self, from: "menu.json")
        
    @EnvironmentObject var order: Order
    
    var body: some View {
        NavigationView {
            MenuListView(menu: menu)
                .navigationTitle("Menu")
        }
    }
}

struct MenuListView: View {
    let menu: [MenuSection]
    
    var body: some View {
        List {
            ForEach(menu, id: \.id) { section in
                MenuSectionView(section: section)
            }
        }
    }
}

struct MenuSectionView: View {
    let section: MenuSection
    
    var body: some View {
        Section(header: Text(section.name)) {
            ForEach(section.items, id: \.id) { item in
                MenuItemNavigationLink(
                    item: item,
                    sectionName: section.name
                )
            }
        }
    }
}

struct MenuItemNavigationLink: View {
    let item: MenuItem
    let sectionName: String
    
    var body: some View {
        NavigationLink {
            ItemDetail(sectionName: sectionName, item: item)
        } label: {
            ItemRow(item: item)
        }
    }
}

struct ItemRow: View {
    var item: MenuItem
    
    let colors: [String: Color] = [
        "D": .purple,
        "G": .black,
        "N": .red,
        "S": .blue,
        "V": .green
    ]
    
    var body: some View {
        HStack {
            Image(item.thumbnailImage)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.green, lineWidth: 1))
            
            VStack(alignment: .leading) {
                Text(item.name)
                Text("\(item.price, format: .currency(code: "TRY"))")
            }
            
            Spacer()
            
            ForEach(item.restrictions, id: \.self) { restriction in
                Text(restriction)
                    .font(.caption)
                    .fontWeight(.black)
                    .padding(5)
                    .background(colors[restriction, default: .black])
                    .clipShape(Circle())
                    .foregroundStyle(.white)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview("Main") {
    ContentView()
}

#Preview("ItemRow") {
    ItemRow(item: MenuItem.example)
}
