//
//  MapScreen.swift
//  ReadingBooks
//
//  Created by Begum Unal on 6.01.2023.
//

import SwiftUI
import _MapKit_SwiftUI
import FirebaseAuth
import FirebaseDatabase

struct MapScreen: View {
    @StateObject private var mapViewModel = MapViewModel()
    @State var tracking = MapUserTrackingMode.follow
    //@State var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.789467 , longitude: -122.416772 ), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
    
    var body: some View {
        Map(
            coordinateRegion: $mapViewModel.region,
           interactionModes: MapInteractionModes.all,
           showsUserLocation: true,
           userTrackingMode: $tracking,
            annotationItems: mapViewModel.MapLocations,
           annotationContent: { location in
             MapPin(coordinate: location.coordinate, tint: .red)
           }
        )
        .ignoresSafeArea()
        .onAppear{
            mapViewModel.checkIfLocationsServicesIsEnabled()
            
        }
    }
    
}

struct MapScreen_Previews: PreviewProvider {
    static var previews: some View {
        MapScreen()
    }
}
