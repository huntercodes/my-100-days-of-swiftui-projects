//
//  ContentView.swift
//  BucketList
//
//  Created by hunter downey on 12/21/21.
//

import MapKit
import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ViewModel()
    
    init() {
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(red: 212 / 255, green: 195 / 255, blue: 195 / 255, alpha: 1.00)]
    }
    
    var body: some View {
        if viewModel.isUnlocked {
            NavigationView {
                ZStack {
                    Map(coordinateRegion: $viewModel.mapRegion, annotationItems: viewModel.locations) { location in
                        MapAnnotation(coordinate: location.coordinate) {
                            VStack {
                                Image(systemName: "bookmark.circle")
                                    .resizable()
                                    .foregroundColor(Color(hex: 0x9b0000))
                                    .frame(width: 44, height: 44)
                                    .background(Color(hex: 0xd4c3c3))
                                    .clipShape(Circle())
                                
                                Text(location.name)
                                    .fixedSize()
                            }
                            .onTapGesture {
                                viewModel.selectedPlace = location
                            }
                        }
                    }
                    .ignoresSafeArea()
                    Circle()
                        .fill(Color(hex: 0x000b49))
                        .opacity(0.3)
                        .frame(width: 32, height: 32)
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            Button {
                                viewModel.addLocation()
                            } label: {
                                Image(systemName: "plus")
                                    .padding()
                                    .background(Color(hex: 0x9b0000).opacity(0.75))
                                    .foregroundColor(Color(hex: 0xd4c3c3))
                                    .font(.title)
                                    .clipShape(Circle())
                                    .padding(.trailing)
                            }
                        }
                    }
                }
                .sheet(item: $viewModel.selectedPlace) { place in
                    EditView(location: place) { newLocation in
                        viewModel.update(location: newLocation)
                    }
                }
            }
        } else {
            Button("Unlock Places") {
                viewModel.authenticate()
            }
            .padding()
            .background(Color(hex: 0x9b0000))
            .foregroundColor(Color(hex: 0xd4c3c3))
            .clipShape(Capsule())
            .alert("Authentication error", isPresented: $viewModel.isShowingAuthError) {
                Button("OK") { }
            } message: {
                Text(viewModel.authenticationError)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
