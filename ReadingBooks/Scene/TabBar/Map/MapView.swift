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
    //genel bir merkez koordinatları ve o koordinatlara ne kadar uzaklıktan görüneceğini bir değişkende tuttum.
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 41.0082 , longitude: 28.9784 ), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
    
    var body: some View {
        Map(coordinateRegion: $region, showsUserLocation: true)
            .ignoresSafeArea()
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
