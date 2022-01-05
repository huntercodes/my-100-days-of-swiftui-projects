//
//  EditView.swift
//  BucketList
//
//  Created by hunter downey on 12/23/21.
//

import SwiftUI

struct EditView: View {
    @StateObject private var viewModel: ViewModel
    
    @Environment(\.dismiss) var dismiss
    var onSave: (Location) -> Void
    
    var body: some View {
        NavigationView {
            Form {
                Section("location information") {
                    TextField("Name", text: $viewModel.name)
                        .foregroundColor(Color(hex: 0xd4c3c3))
                    TextField("Description", text: $viewModel.description)
                        .foregroundColor(Color(hex: 0xd4c3c3))
                }
                .foregroundColor(Color(hex: 0xd4c3c3))
                
                Section("places nearby...") {
                    switch viewModel.loadingState {
                    case .loading:
                        Text("Loading...")
                            .foregroundColor(Color(hex: 0xd4c3c3))
                    case .loaded:
                        ForEach(viewModel.pages, id: \.pageid) { page in
                            Text(page.title)
                                .font(.headline)
                                .foregroundColor(Color(hex: 0xd4c3c3))
                            + Text(": ") +
                            Text(page.description)
                                .italic()
                                .foregroundColor(Color(hex: 0xd4c3c3))
                        }
                    case .failed:
                        Text("Please try again later.")
                            .foregroundColor(Color(hex: 0xd4c3c3))
                    }
                }
                .foregroundColor(Color(hex: 0xd4c3c3))
            }
            .navigationTitle("Place details")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button("Save") {
                    let newLocation = viewModel.createNewLocation()
                    onSave(newLocation)
                    dismiss()
                }
                .foregroundColor(Color(hex: 0xd4c3c3))
            }
            .task {
                await viewModel.fetchNearbyPlaces()
            }
        }
    }
    
    init(location: Location, onSave: @escaping (Location) -> Void) {
        self.onSave = onSave
        _viewModel = StateObject(wrappedValue: ViewModel(location: location))
    }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView(location: Location.example) { newLocation in }
            .preferredColorScheme(.dark)
    }
}
