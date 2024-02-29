//
//  ContentView.swift
//  TimerApp
//
//  Created by Alberto Almeida on 29/02/24.
//

import SwiftUI


struct ContentView: View {
    @State private var timeRemaining = 100
    @State private var widthCustom = CGFloat(Float(350))
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @Environment(\.scenePhase) var scenePhase
    @State private var isActive = true
    @State private var play = false
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(.green, lineWidth: 20)
                .fill(.white)
                .frame(maxWidth: widthCustom)
            HStack {
                Button("Play", systemImage: !play ? "play.fill" : "stop.fill") {
                    play.toggle()
                }
                    .labelStyle(.iconOnly)
                Text("\(timeRemaining)")
                    .onReceive(timer) { time in
                        guard isActive else { return }
                        guard play else { return }
                        
                        if timeRemaining > 0 {
                            timeRemaining -= 1
                            widthCustom -= 2
                        }

                            
                    }
                    .onChange(of: scenePhase) {
                        if scenePhase == .active {
                            isActive = true
                        } else {
                            isActive = false
                        }
                    }
                Button("Redo", systemImage: "arrow.uturn.forward.circle") {
                    timeRemaining = 100
                    widthCustom = 350
                }
                
            }
        }
    }
}

#Preview {
    ContentView()
}
