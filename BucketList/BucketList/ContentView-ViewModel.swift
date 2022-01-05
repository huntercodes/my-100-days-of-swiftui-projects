//
//  ContentView-ViewModel.swift
//  BucketList
//
//  Created by hunter downey on 12/27/21.
//

import Foundation
import LocalAuthentication
import MapKit

extension ContentView {
    @MainActor class ViewModel: ObservableObject {
        @Published var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 40, longitude: -95), span: MKCoordinateSpan(latitudeDelta: 31, longitudeDelta: 31))
        @Published private(set) var locations: [Location]
        @Published var selectedPlace: Location?
        @Published var isUnlocked = false
        @Published var authenticationError = "Unknown error"
        @Published var isShowingAuthError = false
        
        let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedPlaces")
        
        init() {
            do {
                let data = try Data(contentsOf: savePath)
                locations = try JSONDecoder().decode([Location].self, from: data)
            } catch {
                locations = []
            }
        }
        
        func save() {
            do {
                let data = try JSONEncoder().encode(locations)
                try data.write(to: savePath, options: [.atomicWrite, .completeFileProtection])
            } catch {
                print("Unable to save data.")
            }
        }
        
        func addLocation() {
            let newLocation = Location(id: UUID(), name: "", description: "", latitude: mapRegion.center.latitude, longitude: mapRegion.center.longitude)
            locations.append(newLocation)
            save()
        }
        
        func update(location: Location) {
            guard let selectedPlace = selectedPlace else { return }
            
            if let index = locations.firstIndex(of: selectedPlace) {
                locations[index] = location
                save()
            }
        }
        
        func authenticate() {
            let context = LAContext()
            var error: NSError?
            
            if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) {
                let reason = "Please authenticate yourself to unlock your data."
                
                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                    Task { @MainActor in
                        if success {
                            self.isUnlocked = true
                        } else {
                            self.authenticationError = "There was an authentication problem."
                            self.isShowingAuthError = true
                        }
                    }
                }
            } else {
                authenticationError = "Sorry, your device does not support biometric authentication."
                isShowingAuthError = true
            }
        }
    }
}
