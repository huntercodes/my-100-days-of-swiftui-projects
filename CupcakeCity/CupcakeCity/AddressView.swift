//
//  AddressView.swift
//  CupcakeCity
//
//  Created by hunter downey on 12/7/21.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var order: SharedOrder
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $order.data.name)
                    .foregroundColor(Color(hex: 0xedd2f3))
                TextField("Street Address", text: $order.data.streetAddress)
                    .foregroundColor(Color(hex: 0xedd2f3))
                TextField("City", text: $order.data.city)
                    .foregroundColor(Color(hex: 0xedd2f3))
                TextField("Zip Code", text: $order.data.zip)
                    .foregroundColor(Color(hex: 0xedd2f3))
            }
            
            Section {
                NavigationLink {
                    CheckoutView(order: order)
                } label: {
                    Text("Check Out")
                        .padding(7)
                                .background(Color(hex: 0x516beb))
                                .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color(hex: 0x84dfff), lineWidth: 2)
                                )
                        .foregroundColor(Color(hex: 0xedd2f3))
                }
            }
            .disabled(order.data.hasValidAddress == false)
        }
        .navigationTitle("Delivery Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(order: SharedOrder())
            .preferredColorScheme(.dark)
    }
}
