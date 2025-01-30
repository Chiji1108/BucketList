//
//  Location.swift
//  BucketList
//
//  Created by 千々岩真吾 on 2025/01/30.
//

import Foundation
import MapKit

struct Location: Codable, Equatable, Identifiable {
    let id: UUID
    var name: String
    var description: String
    let latitude: Double
    let longitude: Double

    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }

    static func == (lhs: Location, rhs: Location) -> Bool {
        lhs.id == rhs.id && lhs.name == rhs.name && lhs.description == rhs.description
            && lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }

    #if DEBUG
        static let example = Location(
            id: UUID(), name: "Buckingham Palace", description: "Lit by over 40,000 lightbulbs.",
            latitude: 51.501, longitude: -0.141)
    #endif
}
