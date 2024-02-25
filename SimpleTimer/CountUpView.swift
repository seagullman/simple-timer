//
//  CountUpView.swift
//  SimpleTimer
//
//  Created by Brad Siegel on 2/23/24.
//

import SwiftUI
import ComposableArchitecture

struct CountUpView: View {
    let store: StoreOf<TimerViewModel>
    let impactMed = UIImpactFeedbackGenerator(style: .medium)
    
    var body: some View {
        
        VStack {
            
            // MARK: Timer Text
            
            Text(timeString(for: store.secondsElapsed))
                .padding()
                .font(.system(size: 120))
                .lineLimit(1)
                .minimumScaleFactor(0.01)
                .monospacedDigit()
                .fontWeight(.bold)
                .foregroundStyle(.white)
            
                
            // MARK: Start/Stop Button
            
            Button(action: {
                impactMed.impactOccurred()
                if store.isTimerActive {
                    store.send(.stopTapped)
                } else {
                    store.send(.startTapped)
                }
                UIApplication.shared.isIdleTimerDisabled.toggle() // TODO: look into this more
            }, label: {
                Image(systemName: store.isTimerActive ? "stop.circle.fill" : "play.circle.fill")
                    .resizable()
                    .frame(width: 70, height: 70)
                    .foregroundColor(.orange)
            })
        }
        .overlay(alignment: .bottomTrailing) {
            
            // MARK: Reset button
            if !store.isTimerActive && store.secondsElapsed > 0 {
                Button(action: {
                    impactMed.impactOccurred()
                    store.send(.resetTapped)
                }, label: {
                    Image(systemName: "gobackward")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .foregroundColor(.white)
                })
            }
        }
    }
    
    func timeString(for elapsedTime: Int) -> String {
        let hour = elapsedTime / 3600
        let minute = (elapsedTime / 60) % 60
        let second = elapsedTime % 60
        
        return String(format: "%02i:%02i:%02i", hour, minute, second)
    }
    
}

#Preview {
    CountUpView(store: Store(initialState: TimerViewModel.State(), reducer: {
        TimerViewModel()
    }))
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color.black)
}
