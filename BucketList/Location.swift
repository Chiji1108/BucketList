//
//  Location.swift
//  BucketList
//
//  Created by 千々岩真吾 on 2025/01/30.
//

import Foundation

struct Location: Codable, Equatable, Identifiable {
    var id: UUID
    var name: String
    var description: String
    let latitude: Double
    let longitude: Double
}
