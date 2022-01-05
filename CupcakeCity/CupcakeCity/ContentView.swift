//
//  ContentView.swift
//  CupcakeCity
//
//  Created by hunter downey on 12/6/21.
//

import SwiftUI

struct ContentView: View {
    @StateObject var order = SharedOrder()
    
    init() {
        let coloredAppearance = UINavigationBarAppearance()
        
        coloredAppearance.titleTextAttributes = [.foregroundColor: UIColor(red: 237/255, green: 210/255, blue: 243/255, alpha: 1.0)]
        
        UITableView.appearance().backgroundColor = .clear
        UITableViewHeaderFooterView.appearance().tintColor = UIColor.clear
                        
        UINavigationBar.appearance().standardAppearance = coloredAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
    }
    
    var body: some View {
        VStack {
            NavigationView {
                Form {
                    Section {
                        Picker("Select your cake type", selection: $order.data.type) {
                            ForEach(SharedOrder.types.indices) {
                                Text(SharedOrder.types[$0])
                                    .foregroundColor(Color(hex: 0xedd2f3))
                            }
                        }
                        .padding(7)
                                .background(Color(hex: 0x516beb))
                                .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color(hex: 0x84dfff), lineWidth: 2)
                                )
                        .foregroundColor(Color(hex: 0xedd2f3))
                        
                        Stepper("Number of cakes: \(order.data.quantity)", value: $order.data.quantity, in: 3...20)
                            .padding(3)
                                    .background(Color(hex: 0x516beb))
                                    .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(Color(hex: 0x84dfff), lineWidth: 2)
                                    )
                            .foregroundColor(Color(hex: 0xedd2f3))
                    }
                    
                    Section {
                        Toggle("Any special requests?", isOn: $order.data.specialRequestEnabled.animation())
                            .padding(5)
                                    .background(Color(hex: 0x516beb))
                                    .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(Color(hex: 0x84dfff), lineWidth: 2)
                                    )
                            .foregroundColor(Color(hex: 0xedd2f3))
                        
                        if order.data.specialRequestEnabled {
                            Toggle("Add extra frosting", isOn: $order.data.extraFrosting)
                                .padding(5)
                                        .background(Color(hex: 0x516beb))
                                        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 8)
                                                .stroke(Color(hex: 0x84dfff), lineWidth: 2)
                                        )
                                .foregroundColor(Color(hex: 0xedd2f3))
                            
                            Toggle("Add extra sprinkles", isOn: $order.data.addSprinkles)
                                .padding(5)
                                        .background(Color(hex: 0x516beb))
                                        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 8)
                                                .stroke(Color(hex: 0x84dfff), lineWidth: 2)
                                        )
                                .foregroundColor(Color(hex: 0xedd2f3))
                        }
                    }
                    
                    Section {
                        NavigationLink {
                            AddressView(order: order)
                                .background(Color(hex: 0x84dfff))
                        } label: {
                            Text("Delivery Details")
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
                }
                .background(Color(hex: 0x84dfff))
                .navigationTitle("Cupcake City")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
