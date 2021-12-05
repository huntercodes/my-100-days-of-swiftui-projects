//
//  ContentView.swift
//  HabitTrack
//
//  Created by hunter downey on 12/2/21.
//

import SwiftUI

struct ContentView: View {
    @StateObject var data = Activities()
    @State private var items = Activities()
    @State private var addingNewActivity = false
    
    let columns = [
        GridItem(.adaptive(minimum: 200))
    ]
    
    init() {
            let coloredAppearance = UINavigationBarAppearance()
            
            // this overrides everything you have set up earlier.
            coloredAppearance.titleTextAttributes = [.foregroundColor: UIColor(red: 87/255, green: 123/255, blue: 193/255, alpha: 1.0)]
            
            // to make everything work normally
            UINavigationBar.appearance().standardAppearance = coloredAppearance
            UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
        }
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(data.activities, id: \.self) { activity in
                        NavigationLink {
                            ActivityView(data: data, activity: activity)
                        } label: {
                            VStack {
                                Text(activity.title)
                                    .font(.caption2.italic().weight(.heavy))
                                    .foregroundColor(Color(hex: 0x494546))
                                    .padding(7)
                                    .frame(minWidth: 50)
                                    .background(color(for: activity))
                                    .clipShape(RoundedRectangle(cornerRadius: 7))
                                
                                Spacer()
                                
                                VStack {
                                    Text(String(activity.completionCount))
                                        .font(.caption2.italic().weight(.heavy))
                                        .foregroundColor(Color(hex: 0x494546))
                                        .padding(7)
                                        .frame(minWidth: 20)
                                        .background(color(for: activity))
                                        .clipShape(RoundedRectangle(cornerRadius: 7))
                                }
                                .padding(.vertical)
                                .frame(maxWidth: .infinity)
                                .background(Color(hex: 0xd3d3d3))
                            }
                            .clipShape(Capsule())
                            .overlay(
                                Capsule()
                                    .stroke(Color(hex: 0xd3d3d3))
                            )
                        }
                    }
                }
            }
            .background(Color(hex: 0x494546))
            .navigationTitle("Habit Track")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button {
                    addingNewActivity.toggle()
                } label: {
                    Label("Add new activity", systemImage: "plus")
                        .foregroundColor(Color(hex: 0x577bc1))
                }
            }
            .sheet(isPresented: $addingNewActivity) {
                AddActivity(data: data)
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
    
    func color(for activity: Activity) -> Color {
        if activity.completionCount < 10 {
            return Color(hex: 0xdd1e2f)
        } else if activity.completionCount < 20 {
            return Color(hex: 0xebb035)
        } else {
            return Color(hex: 0x218559)
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
