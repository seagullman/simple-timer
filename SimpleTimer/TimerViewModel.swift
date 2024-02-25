//
//  TimerViewModel.swift
//  SimpleTimer
//
//  Created by Brad Siegel on 2/23/24.
//

import Foundation
import ComposableArchitecture

@Reducer
struct TimerViewModel {
    let clock = ContinuousClock()
    
    var body: some ReducerOf<TimerViewModel> {
        Reduce { state, action in
            switch action {
            case .startTapped:
                state.isTimerActive = true
                return .run { send in
                    for await _ in clock.timer(interval: .seconds(1)) {
                        await send(.timerTicked)
                    }
                }
                .cancellable(id: CancelId.timer)
            case .stopTapped:
                state.isTimerActive = false
                return .cancel(id: CancelId.timer)
            case .timerTicked:
                state.secondsElapsed += 1
                return .none
            case .resetTapped:
                state.secondsElapsed = 0
                return .none
            case .backgroundTapped:
                state.overlayIsShowing.toggle()
                return .none
            }
        }
    }
    
    @ObservableState
    struct State: Equatable {
        var isTimerActive = false
        var secondsElapsed = 0
        var overlayIsShowing = false
    }
    
    enum Action: Equatable {
        case startTapped
        case stopTapped
        case timerTicked
        case resetTapped
        case backgroundTapped
    }
    
    private enum CancelId {
        case timer
    }
}
