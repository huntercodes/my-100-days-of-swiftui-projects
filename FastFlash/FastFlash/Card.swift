//
//  Card.swift
//  FastFlash
//
//  Created by hunter downey on 1/10/22.
//

import Foundation

struct Card: Codable {
    let prompt: String
    let answer: String
    
    static var example: Card {
        Card(prompt: "What collection types are there in Swift?", answer: "Arrays, Sets, and Dictionaries")
    }
}
