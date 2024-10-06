//
//  ContentView.swift
//  SleepHours
//
//  Created by Andy Dang It on 10/5/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var wakeUp = Date.now
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    
    var body: some View {
        NavigationStack {
            VStack {
                
                //When to wake up
                Text("When do you want to wake up?")
                    .font(.headline)
                DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                    .labelsHidden()
                
                // Desire to Sleep
                Text("Desired amount of sleep")
                    .font(.headline)
                Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...7, step: 0.25)
                
                // Coffee Amount
                Text("Daily coffee intake")
                    .font(.headline)
                Stepper("\(coffeeAmount) cups", value: $coffeeAmount, in: 0...11)
                
            }
            .navigationTitle("Sleep Hours")
            .toolbar {
                Button("calculate", action: calculateBedTime)
            }
        }
    }
    
    func calculateBedTime() {
        
    }
    
}

#Preview {
    ContentView()
}
