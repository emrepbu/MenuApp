//
//  OrderView.swift
//  MenuApp
//
//  Created by emre argana on 14.06.2025.
//

import SwiftUI

struct OrderView : View {
    @EnvironmentObject var order: Order

    var body: some View {
        NavigationStack {
            List {
                Section {
                    ForEach(order.items, id: \.self) { item in
                        HStack {
                            Text(item.name)
                            Spacer()
                            Text("\(item.price, format: .currency(code: "TRY"))")
                        }
                    }
                }

                Section {
                    NavigationLink("Place Order") {
                        CheckoutView()
                    }
                }
            }
            .navigationTitle("Order")
        }
    }
}


#Preview {
    OrderView()
}
