//
//  ContentView.swift
//  SleepHours
//
//  Created by Andy Dang It on 10/5/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var sleepAmount = 8.0
    
    var body: some View {
        Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 5...12, step: 0.25)
    }
}

#Preview {
    ContentView()
}
