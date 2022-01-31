//
//  Resort.swift
//  SeekTheSnow
//
//  Created by hunter downey on 1/27/22.
//

import Foundation

struct Resort: Codable, Identifiable {
    let id: String
    let name: String
    let country: String
    let description: String
    let imageCredit: String
    let price: Int
    let size: Int
    let snowDepth: Int
    let elevation: Int
    let runs: Int
    let facilities: [String]
    
    static let allResults: [Resort] = Bundle.main.decode("resorts.json")
    static let example = allResults[4]
    
    var facilityTypes: [Facility] {
        facilities.map(Facility.init)
    }
}
