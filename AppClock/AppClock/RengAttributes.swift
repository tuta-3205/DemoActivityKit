//
//  RengAttributes.swift
//  AppClock
//
//  Created by tran.anh.tub on 15/09/2023.
//

import ActivityKit
import SwiftUI

// TODO: 1. Create Attributes
struct RengAttributes: ActivityAttributes {
    public typealias TimerStatus = ContentState
    var timerName: String

    public struct ContentState: Codable & Hashable {
        var endTime: Date
        var startTime: Date
        var inProgress: Bool
    }
}
