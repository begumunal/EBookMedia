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
    
    //genel bir merkez koordinatları ve o koordinatlara ne kadar uzaklıktan görüneceğini bir değişkende tuttum.
    @Published var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.331516 , longitude: -121.891054 ), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
    
    @Published var regions : [MKCoordinateRegion] = [MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.789467 , longitude: -122.416772 ), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))]
    
     var MapLocations = [
            MapLocation(name: "St Francis Memorial Hospital", latitude: 37.789467, longitude: -122.416772),
            MapLocation(name: "The Ritz-Carlton, San Francisco", latitude: 37.791965, longitude: -122.406903),
            MapLocation(name: "Honey Honey Cafe & Crepery", latitude: 37.787891, longitude: -122.411223)
            ]
    
    var locationManager : CLLocationManager? //kullanıcın konumunu tutacağımız değişken - kullanıcı konum servisini kapatmış olabilir bu yüzden opsional
    
    //konum hizmetlerinin etkin olup olmadığının kontrolü
    func checkIfLocationsServicesIsEnabled(){
        if CLLocationManager.locationServicesEnabled(){//eğer etkinse
            locationManager = CLLocationManager() //konumunu atadık.
            locationManager!.delegate = self
            checkLocationAuthorization()
            //bu konumu veritabanında kaydetmeliyim.
            mapDataSet()
        }else{
            print("Show an alert letting then know this is off and to go turn it on.")
        }
    }
    
    private func checkLocationAuthorization(){
        guard let locationManager = locationManager else{ return }
        switch locationManager.authorizationStatus{
            
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("your location is restricted likely due to parental controls")
        case .denied:
            print("you have denied thisapp location permission. Go into settings to change it")
        case .authorizedAlways , .authorizedWhenInUse: break
            
           // mapDataGet()
            //region = MKCoordinateRegion(center: locationManager.location!.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
            region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.789467 , longitude: -122.416772 ), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
        @unknown default:
            break
        }
    }
    //konum servisinin kullanılıp kullanılmadığının kontrolünü sürekli yapar.
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
    //kullanıcının konumunun veritabanına kaydedildiği fonk.
    
    func mapDataSet(){
        let id = Auth.auth().currentUser?.uid
        var ref : DatabaseReference!
        ref = Database.database().reference()
        let readingBy = Auth.auth().currentUser!.email!
        
        ref.child("userLocations").child(id!).setValue(["location" : "\(self.locationManager?.location?.coordinate)"] )
    }
    func mapDataGet(){
        let id = Auth.auth().currentUser?.uid
        var ref: DatabaseReference! = Database.database().reference()
        var location = CLLocationCoordinate2D()
        var mapLocation = MapLocation(name: "", latitude: 0, longitude: 0)
        ref.child("userLocations").observe(.value, with: { (snapshot) in
            if snapshot.value != nil{
                for child in snapshot.children{
                    let childSnapshot = child as! DataSnapshot
                    if childSnapshot.hasChild("location"){
                        location = childSnapshot.childSnapshot(forPath: "location").value as! CLLocationCoordinate2D 
                        mapLocation.name = "deneme"
                        mapLocation.latitude = location.latitude
                        mapLocation.longitude = location.longitude
                        self.MapLocations.append(mapLocation)
                    }
                }
            }
        })
    }
}
