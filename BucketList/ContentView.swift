//
//  ContentView.swift
//  BucketList
//
//  Created by 千々岩真吾 on 2025/01/28.
//

import MapKit
import SwiftUI

struct ContentView: View {
    @State private var viewModel = ViewModel()

    let startPosition = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 56, longitude: -3),
            span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
        )
    )

    var body: some View {
        MapReader { proxy in
            Map(initialPosition: startPosition) {
                ForEach(viewModel.locations) { location in
                    Annotation(
                        location.name,
                        coordinate: location.coordinate
                    ) {
                        Image(systemName: "star.fill")
                            .resizable()
                            .foregroundStyle(.yellow)
                            .frame(width: 32, height: 32)
                            .highPriorityGesture(
                                TapGesture().onEnded { _ in
                                    viewModel.selectedPlace = location
                                }
                            )
                    }
                }
            }
            .onTapGesture { position in
                if let coordinate = proxy.convert(position, from: .local) {
                    viewModel.addLocation(at: coordinate)
                }
            }
            .sheet(item: $viewModel.selectedPlace) { place in
                EditView(location: place) { newLocation in
                    viewModel.update(location: newLocation)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
