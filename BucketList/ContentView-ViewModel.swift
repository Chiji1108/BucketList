//
//  ContentView-ViewModel.swift
//  BucketList
//
//  Created by 千々岩真吾 on 2025/02/02.
//

import Foundation
import LocalAuthentication
import MapKit

extension ContentView {
    @Observable
    class ViewModel {
        private(set) var locations: [Location]
        var selectedPlace: Location?
        let savePath = URL.documentsDirectory.appending(path: "SavedPlaces")
        var isUnlocked = false
        var authenticationError = "Unknown error"
        var isShowingAuthenticationError = false

        init() {
            do {
                let data = try Data(contentsOf: savePath)
                locations = try JSONDecoder().decode([Location].self, from: data)
            } catch {
                print("Failed to load locations")
                locations = []
            }
        }

        func save() {
            do {
                let data = try JSONEncoder().encode(locations)
                try data.write(to: savePath, options: [.atomic, .completeFileProtection])
            } catch {
                print("Failed to save locations")
            }
        }

        func addLocation(at point: CLLocationCoordinate2D) {
            let newLocation = Location(
                id: UUID(),
                name: "New location",
                description: "",
                latitude: point.latitude,
                longitude: point.longitude
            )
            locations.append(newLocation)
            save()
        }

        func update(location: Location) {
            guard let selectedPlace else { return }

            if let index = locations.firstIndex(of: selectedPlace) {
                locations[index] = location
                save()
            }
        }

        func authenticate() {
            let context = LAContext()
            var error: NSError?

            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                let reason = "Please authenticate yourself to unlock your places."

                context.evaluatePolicy(
                    .deviceOwnerAuthenticationWithBiometrics, localizedReason: reason
                ) { success, authenticationError in

                    if success {
                        self.isUnlocked = true
                    } else {
                        // error
                        self.authenticationError = "Failed to authenticate."
                        self.isShowingAuthenticationError = true
                    }
                }
            } else {
                // no biometrics
                authenticationError = "Your device does not support biometric authentication."
                isShowingAuthenticationError = true
            }
        }
    }
}
