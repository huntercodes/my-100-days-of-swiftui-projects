//
//  ExpenseItem.swift
//  iExpense
//
//  Created by hunter downey on 11/20/21.
//

import Foundation

struct ExpenseItem: Identifiable, Codable, Equatable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}
