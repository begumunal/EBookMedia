//
//  MapView.swift
//  ReadingBooks
//
//  Created by Begum Unal on 12.10.2022.
//

import SwiftUI
import MapKit

struct MapView: View {
    
    @StateObject private var mapViewModel = MapViewModel()
   
    var body: some View {
        Map(coordinateRegion:
                $mapViewModel.region, showsUserLocation: true)
            .ignoresSafeArea()
            .onAppear{
                mapViewModel.checkIfLocationsServicesIsEnabled()
            }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
