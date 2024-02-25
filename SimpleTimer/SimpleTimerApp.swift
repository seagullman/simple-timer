//
//  SimpleTimerApp.swift
//  SimpleTimer
//
//  Created by Brad Siegel on 2/23/24.
//

import SwiftUI
import SwiftData
import ComposableArchitecture

@main
struct SimpleTimerApp: App {
    var body: some Scene {
        WindowGroup {
            TimerView(store: Store(initialState: TimerViewModel.State(), reducer: {
                TimerViewModel()._printChanges()
            }))
        }
    }
}
