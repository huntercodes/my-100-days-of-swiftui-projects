//
//  FormatStyle-LocalCurrency.swift
//  iExpense
//
//  Created by hunter downey on 11/21/21.
//

import Foundation

extension FormatStyle where Self == FloatingPointFormatStyle<Double>.Currency {
    static var localCurrency: Self {
        .currency(code: Locale.current.currencyCode ?? "USD")
    }
}
