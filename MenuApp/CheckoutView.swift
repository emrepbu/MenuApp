//
//  CheckoutView.swift
//  MenuApp
//
//  Created by emre argana on 14.06.2025.
//

import SwiftUI

struct CheckoutView: View {
    @EnvironmentObject var order: Order
    @Environment(\.dismiss) private var dismiss
    @State private var selectedPaymentType: String = "Cash"
    @State private var showingConfirmation = false
    @State private var animateEntrance = false
    
    let paymentTypes = ["Cash", "Credit Card", "Plus Points"]
    
    var body: some View {
        ZStack {
            Image("bg")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .overlay(Color.black.opacity(0.18))
                .transition(.opacity)
            
            VStack(spacing: 24) {
                Text("Order Summary")
                    .font(.title2)
                    .bold()
                Divider()
                    .padding(.bottom, -8)
                
                Text("Total \(order.total, format: .currency(code: "TRY"))")
                    .font(.headline)
                    .padding(.bottom)
                
                Picker("Payment Type", selection: $selectedPaymentType) {
                    ForEach(paymentTypes, id: \.self) { type in
                        Text(type)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.bottom)
                
                HStack {
                    Image(systemName: selectedPaymentType == "Cash" ? "banknote" : (selectedPaymentType == "Credit Card" ? "creditcard" : "star.circle"))
                        .foregroundColor(.accentColor)
                    Text("Paying with: \(selectedPaymentType)")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    Spacer()
                }
                .padding(.vertical, 2)
                
                Button(action: {
                    UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                    showingConfirmation = true
                }) {
                    Text("Place Order")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.primary)
                        .foregroundColor(.white)
                        .cornerRadius(16)
                        .shadow(radius: 4, y: 2)
                }
            }
            .padding(32)
            .padding(.top, 12)
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 32, style: .continuous))
            .shadow(radius: 18, y: 8)
            .scaleEffect(animateEntrance ? 1 : 0.92)
            .opacity(animateEntrance ? 1 : 0)
            .animation(.spring(response: 0.6, dampingFraction: 0.7), value: animateEntrance)
            .onAppear {
                animateEntrance = true
            }
        }
        .padding()
        .alert("Order Confirmed!", isPresented: $showingConfirmation) {
            Button("OK", role: .confirm) {
                order.items.removeAll()
                dismiss()
            }
        } message: {
            Text("Thank you for your order. Your payment type: \(selectedPaymentType)")
        }
    }
}

#Preview {
    CheckoutView()
}
