//
//  ViewExpenseStyling.swift
//  iExpense
//
//  Created by hunter downey on 11/21/21.
//

import SwiftUI

extension View {
    func style(for item: ExpenseItem) -> some View {
        if item.amount < 10 {
            return self.font(.body)
        } else if item.amount < 100 {
            return self.font(.title3)
        } else {
            return self.font(.title2)
        }
    }
}
