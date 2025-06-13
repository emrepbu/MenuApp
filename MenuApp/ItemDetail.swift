import SwiftUI

struct ItemDetail: View {
    let sectionName: String
    let item: MenuItem
    
    @EnvironmentObject var order: Order
    @Namespace private var namespace

    let colors: [String: Color] = [
        "D": .purple,
        "G": .black,
        "N": .red,
        "S": .blue,
        "V": .green
    ]
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                ZStack(alignment: .bottomTrailing) {
                    Image(item.mainImage)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity, maxHeight: 200)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                    
                    Text("Photo: \(item.photoCredit)")
                        .padding(4)
                        .background(.white)
                        .font(.caption)
                        .foregroundStyle(.black)
                        .clipShape(
                            .rect(
                                topLeadingRadius: 6,
                                bottomLeadingRadius: 0,
                                bottomTrailingRadius: 6,
                                topTrailingRadius: 0
                            )
                        )
                }
                
                HStack {
                    VStack(alignment: .leading) {
                        Text(item.name)
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Text("\(item.price, format: .currency(code: "TRY"))")
                            .font(.headline)
                            .foregroundColor(.secondary)
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
                
                Divider()
                
                Button("Order This") {
                    order.add(item: item)
                }
                
                Text(item.description)
                    .font(.body)
                    .padding(.top)
            }
            .padding()
        }
        .navigationTitle(sectionName)
        .navigationBarTitleDisplayMode(.large)
    }
}

#Preview {
    ItemDetail(sectionName: "Main", item: MenuItem.example)
        .environmentObject(Order())
}
