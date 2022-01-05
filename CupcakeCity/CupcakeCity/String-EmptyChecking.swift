//
//  String-EmptyChecking.swift
//  CupcakeCity
//
//  Created by hunter downey on 12/7/21.
//

import Foundation

extension String {
    var isReallyEmpty: Bool {
        self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
