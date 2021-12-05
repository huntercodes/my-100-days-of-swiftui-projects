//
//  AddActivity.swift
//  HabitTrack
//
//  Created by hunter downey on 12/2/21.
//

import SwiftUI

struct AddActivity: View {
    @ObservedObject var data: Activities
    @State private var title = ""
    @State private var description = ""
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Habit", text: $title)
                TextField("Description", text: $description)
            }
            .background(Color(hex: 0x494546))
            .navigationTitle("Add Habit")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button("Save") {
                    let trimmedTitle = title.trimmingCharacters(in: .whitespaces)
                    guard trimmedTitle.isEmpty == false else { return }
                    
                    let activity = Activity(title: trimmedTitle, description: description)
                    data.activities.append(activity)
                    dismiss()
                }
                .foregroundColor(Color(hex: 0x577bc1))
            }
        }
    }
}

struct AddActivity_Previews: PreviewProvider {
    static var previews: some View {
        AddActivity(data: Activities())
    }
}
