//
//  ContentView.swift
//  SleepHours
//
//  Created by Andy Dang It on 10/5/24.
//

import CoreML
import SwiftUI

struct ContentView: View {
    
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    
    @State private var bedtime = ""
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 6
        components.minute = 0
        return Calendar.current.date(from: components) ?? .now
    }
    
    var body: some View {
        NavigationStack {
            Form {
                //When to wake up
                Section {
                    Text("When do you want to wake up?")
                        .font(.headline)
                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                        .onChange(of: wakeUp) {
                            calculateBedTime()
                        }
                }
                
                
                // Desire to Sleep
                Section {
                    Text("Desired amount of sleep")
                        .font(.headline)
                    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...7, step: 0.25)
                        .onChange(of: sleepAmount) {
                            calculateBedTime()
                        }
                }
                
                
                // Coffee Amount
                Section {
                    Text("Daily coffee intake")
                        .font(.headline)
                    Picker("Number of cups", selection: $coffeeAmount) {
                        ForEach(1..<12) { number in
                            Text("\(number) \(number == 1 ? "cup" : "cups")")
                        }
                    }
                    .onChange(of: coffeeAmount) {
                        calculateBedTime()
                    }
                }
                
                
                //Bedtime Display
                VStack {
                    Text("Your Ideal bedtime is:")
                     Text(bedtime)
                         .font(.largeTitle)
                         .bold()
                         .frame(maxWidth: .infinity, alignment: .center)
                         .padding()
                         .onAppear{
                             calculateBedTime()
                         }
                 }
                .navigationTitle("Sleep Hours")
            }
            
        }
        
        
    }
    func calculateBedTime() {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculators(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            
            let sleepTime = wakeUp - prediction.actualSleep
            
            bedtime = sleepTime.formatted(date: .omitted, time: .shortened)
            
        }catch {
            bedtime = "Error calculating bedtime"
        }
        showingAlert = true
        
    }
}

#Preview {
    ContentView()
}
