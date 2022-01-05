//
//  Order.swift
//  CupcakeCity
//
//  Created by hunter downey on 12/7/21.
//

import SwiftUI

@dynamicMemberLookup
class SharedOrder: ObservableObject {
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    @Published var data = Order()
    
    subscript<T>(dynamicMember keyPath: KeyPath<Order, T>) -> T {
        data[keyPath: keyPath]
    }
    
    subscript<T>(dynamicMember keyPath: WritableKeyPath<Order, T>) -> T {
        get {
            data[keyPath: keyPath]
        }
        
        set {
            data[keyPath: keyPath] = newValue
        }
    }
}

struct Order: Codable {
    enum CodingKeys: CodingKey {
        case type, quantity, extraFrosting, addSprinkles, name, streetAddress, city, zip
    }
    
    var type = 0
    var quantity = 3
    
    var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    
    var extraFrosting = false
    var addSprinkles = false
    
    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""
    
    var hasValidAddress: Bool {
        if name.isReallyEmpty || streetAddress.isReallyEmpty || city.isReallyEmpty || zip.isReallyEmpty {
            return false
        }
        
        return true
    }
    
    var cost: Double {
        var cost = Double(quantity) * 2
        
        cost += (Double(type) / 2)
        
        if extraFrosting {
            cost += Double(quantity)
        }
        
        if addSprinkles {
            cost += Double(quantity) / 2
        }
        
        return cost
    }
}
