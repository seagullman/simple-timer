//
//  OverlayView.swift
//  SimpleTimer
//
//  Created by Brad Siegel on 2/25/24.
//

import SwiftUI

struct OverlayView: View {
    var body: some View {
        ZStack(alignment: .top) {
            Rectangle()
                .fill(.black)
                .opacity(0.4)
            
            HStack(spacing: 20) {
                Spacer()
                Text(Date(), style: .time)
                    .font(.largeTitle)
                    .fontWeight(.thin)
                    .foregroundColor(.white)
                
                Button(action: {
                    print("**** go to settings")
                }, label: {
                    Image(systemName: "gearshape")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.white)
                })
            }
            .padding([.top, .trailing])
            .frame(maxWidth: .infinity)
        }
    }
}

#Preview {
    OverlayView()
}
