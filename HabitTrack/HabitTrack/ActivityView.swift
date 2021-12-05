//
//  ActivityView.swift
//  HabitTrack
//
//  Created by hunter downey on 12/2/21.
//

import SwiftUI

struct ActivityView: View {
    @ObservedObject var data: Activities
    var activity: Activity
    
    var body: some View {
        ZStack(alignment: .center) {
            List {
                Section("Habit description:") {
                    if activity.description.isEmpty == false {
                        Text(activity.description)
                    }
                }
                .font(.caption2.italic().weight(.heavy))
                .foregroundColor(Color(hex: 0x494546))
                .padding(7)
                .frame(minWidth: 20)
                .background(color(for: activity))
                .clipShape(RoundedRectangle(cornerRadius: 7))
                
                Section("Completion count:") {
                    Text("\(activity.completionCount)")
                    
                }
                .font(.caption2.italic().weight(.heavy))
                .foregroundColor(Color(hex: 0x494546))
                .padding(7)
                .frame(minWidth: 20)
                .background(color(for: activity))
                .clipShape(RoundedRectangle(cornerRadius: 7))
                
                Button("Mark Completed!") {
                    var newActivity = activity
                    newActivity.completionCount += 1
                    
                    if let index = data.activities.firstIndex(of: activity) {
                        data.activities[index] = newActivity
                    }
                }
                .clipShape(RoundedRectangle(cornerRadius: 7))
                .foregroundColor(Color(hex: 0x577bc1))
                .font(.title3.italic().weight(.heavy))
            }
        }
    }
}

struct ActivityView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityView(data: Activities(), activity: Activity.example)
            .preferredColorScheme(.dark)
    }
}
