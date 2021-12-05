//
//  Activity.swift
//  HabitTrack
//
//  Created by hunter downey on 12/2/21.
//

import Foundation

struct Activity: Codable, Identifiable, Equatable, Hashable {
    var id = UUID()
    var title: String
    var description: String
    var completionCount = 0
    
    static let example = Activity(title: "example activity", description: "this is an example activity")
}
