//
//  MapLocation.swift
//  ReadingBooks
//
//  Created by Begum Unal on 6.01.2023.
//

import Foundation
import CoreLocation

struct MapLocation : Identifiable{
    
    var id = UUID()
    var name : String
    var latitude : Double
    var longitude : Double
    var coordinate: CLLocationCoordinate2D {
            CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
