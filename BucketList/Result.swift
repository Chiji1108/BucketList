//
//  Result.swift
//  BucketList
//
//  Created by 千々岩真吾 on 2025/01/31.
//

import Foundation

struct Result: Codable {
    let query: Query
}

struct Query: Codable {
    let pages: [Int: Page]
}

struct Page: Codable, Comparable {
    let pageid: Int
    let title: String
    let terms: [String: [String]]?

    static func < (lhs: Page, rhs: Page) -> Bool {
        lhs.title < rhs.title
    }

    var description: String {
        terms?["description"]?.first ?? "No further information"
    }
}
