//
//  ContentView.swift
//  SimpleTimer
//
//  Created by Brad Siegel on 2/23/24.
//

import SwiftUI
import ComposableArchitecture

struct TimerView: View {
    let store: StoreOf<TimerViewModel>
    
    var body: some View {
        ZStack {
            
            CountUpView(store: store)
                .disabled(store.overlayIsShowing)
                .blur(radius: store.overlayIsShowing ? 4.0 : 0.0)
            
            
            if store.overlayIsShowing {
                OverlayView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black)
        .onTapGesture {
            store.send(.backgroundTapped)
        }
    }
}

#Preview {
    TimerView(store: Store(initialState: TimerViewModel.State(), reducer: {
        TimerViewModel()
    }))
}
