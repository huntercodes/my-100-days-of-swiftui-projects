//
//  Location.swift
//  BucketList
//
//  Created by hunter downey on 12/23/21.
//

import MapKit
import Foundation

struct Location: Identifiable, Codable, Equatable {
    var id: UUID
    var name: String
    var description: String
    var latitude: Double
    var longitude: Double
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    static let example = Location(id: UUID(), name: "Henry Doorly Zoo", description: "Voted '3rd Greatest Zoo' in the U.S.", latitude: 41.22, longitude: -95.929)
    
    static func ==(lhs: Location, rhs: Location) -> Bool {
        lhs.id == rhs.id
    }
}
