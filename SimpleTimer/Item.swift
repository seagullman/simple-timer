//
//  TimerItem.swift
//  SimpleTimer
//
//  Created by Brad Siegel on 2/23/24.
//

import Foundation
import SwiftData

@Model
final class TimerItem {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
