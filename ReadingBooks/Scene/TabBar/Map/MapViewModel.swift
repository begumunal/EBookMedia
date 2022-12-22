//
//  MapViewModel.swift
//  ReadingBooks
//
//  Created by Begum Unal on 21.12.2022.
//

import Foundation
import MapKit
import FirebaseAuth
import FirebaseCore
import FirebaseDatabase

final class MapViewModel : NSObject, ObservableObject, CLLocationManagerDelegate{
    var locationManager : CLLocationManager? //kullanıcın konumunu tutacağımız değişken - kullanıcı konum servisini kapatmış olabilir bu yüzden opsional
    
    //konum hizmetlerinin etkin olup olmadığının kontrolü
    func checkIfLocationsServicesIsEnabled(){
        if CLLocationManager.locationServicesEnabled(){//eğer etkinse
            locationManager = CLLocationManager() //konumunu atadık.
            checkLocationAuthorization()
            //bu konumu veritabanında kaydetmeliyim.
        }else{
            print("Show an alert letting then know this is off and to go turn it on.")
        }
    }
    
    func checkLocationAuthorization(){
        guard let locationManager = locationManager else{ return }
        switch locationManager.authorizationStatus{
            
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("your location is restricted likely due to parental controls")
        case .denied:
            print("you have denied thisapp location permission. Go into settings to change it")
        case .authorizedAlways , .authorizedWhenInUse:
            break
        @unknown default:
            break
        }
    }
    
    
    //kullanıcının konumunun veritabanına kaydedildiği fonk.
    func mapDatabaseController(){
        let id = Auth.auth().currentUser?.uid
        var ref : DatabaseReference!
        ref = Database.database().reference()
        let readingBy = Auth.auth().currentUser!.email!
        
        ref.child("userLocations").child(id!).setValue(["location" : self.locationManager] )
    }
}
