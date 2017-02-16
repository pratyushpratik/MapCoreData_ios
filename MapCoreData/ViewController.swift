//
//  ViewController.swift
//  MapCoreData
//
//  Created by Sierra 4 on 13/02/17.
//  Copyright © 2017 codebrew. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreLocation

class ViewController: UIViewController, GMSMapViewDelegate, CLLocationManagerDelegate {
    
    
    @IBOutlet var mapView: GMSMapView!
    
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //self.location
        self.locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.startUpdatingLocation()
        //self.mapView.show = true

         print(self.forcast?.dailyForecasts?[0].date ?? "")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //func locationManager{}
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error" + error.localizedDescription)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation = locations.last
        let center = CLLocationCoordinate2D(latitude: userLocation!.coordinate.latitude, longitude: userLocation!.coordinate.longitude)
        //let region = GMSCoordinateBounds
        
        let camera = GMSCameraPosition.camera(withLatitude: userLocation!.coordinate.latitude,
                                                          longitude: userLocation!.coordinate.longitude, zoom: 8)
        let rect = CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: 100, height: 100))
        
        let mapView = GMSMapView.map(withFrame: rect, camera: camera)
        
        mapView.isMyLocationEnabled = true
        
        self.view = mapView
        
        let marker = GMSMarker()
        marker.position = center
        marker.title = "Current Location"
        marker.snippet = "XXX"
        marker.map = mapView
        
        self.locationManager.stopUpdatingLocation()
    }

}

