//
//  ContentView.swift
//  BucketList
//
//  Created by 千々岩真吾 on 2025/01/28.
//

import LocalAuthentication
import MapKit
import SwiftUI

struct Location: Identifiable {
    let id = UUID()
    var name: String
    var coordinate: CLLocationCoordinate2D
}

let locations = [
    Location(
        name: "Buckingham Palace",
        coordinate: CLLocationCoordinate2D(latitude: 51.501, longitude: -0.141)),
    Location(
        name: "Tower of London",
        coordinate: CLLocationCoordinate2D(latitude: 51.508, longitude: -0.076)),
]

struct ContentView: View {
    @State private var isUnlocked = false
    @State private var position = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275),
            span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
        )
    )

    func authenticate() {
        let context = LAContext()
        var error: NSError?

        // check whether biometric authentication is possible
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            // it's possible, so go ahead and use it
            let reason = "We need to unlock your data."

            context.evaluatePolicy(
                .deviceOwnerAuthenticationWithBiometrics, localizedReason: reason
            ) {
                success, authenticationError in
                // authentication has now completed
                if success {
                    // authenticated successfully
                    isUnlocked = true
                } else {
                    // there was a problem
                }
            }
        } else {
            // no biometrics
        }
    }

    var body: some View {
        VStack {
            if isUnlocked {
                Text("Unlocked")
            } else {
                Text("Locked")
            }
        }
        .onAppear(perform: authenticate)
    }
}

#Preview {
    ContentView()
}
