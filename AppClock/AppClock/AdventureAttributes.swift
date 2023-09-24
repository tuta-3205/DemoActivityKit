//
//  AdventureAttributes.swift
//  AppClock
//
//  Created by tran.anh.tub on 15/09/2023.
//

import ActivityKit

struct AdventureAttributes: ActivityAttributes {
    var hero: String

    struct ContentState: Codable & Hashable {
        let currentHealthLevel: Double
        let eventDescription: String
    }
}
