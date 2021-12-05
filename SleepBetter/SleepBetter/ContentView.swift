//
//  ContentView.swift
//  SleepBetter
//
//  Created by hunter downey on 11/8/21.
//

import CoreML
import SwiftUI

struct ContentView: View {
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeIntake = 1
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 6
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date.now
    }
    
    var sleepResults: String {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeIntake))
            
            let sleepTime = wakeUp - prediction.actualSleep
            return "Your ideal bedtime is " + sleepTime.formatted(date: .omitted, time: .shortened)
        } catch {
            return "There was an error"
        }
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section("When do you want to wake up?") {
                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                }
                .foregroundColor(.purple)
                
                Section("Desired amount of sleep?") {
                    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                }
                .foregroundColor(.purple)
                
                Section("Daily coffee intake?") {
                    Picker("Number of cups", selection: $coffeeIntake) {
                        ForEach(1..<21) {
                            Text(String($0))
                        }
                    }
                }
                .foregroundColor(.purple)
                Spacer()
                VStack(alignment: .center) {
                    Text(sleepResults)
                        .padding()
                        .font(.title3)
                }
                Spacer()
            }
            .navigationTitle("SleepBetter")
            .foregroundColor(.purple)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
