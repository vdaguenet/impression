//
//  MapViewController.swift
//  impression
//
//  Created by DAGUENET Valentin on 12/11/15.
//  Copyright © 2015 Arthur Valentin. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var inputText: UITextField!
    @IBOutlet weak var resetPositionBtn: UIButton!
    
    var locationManager = CLLocationManager()
    var userLocation = CLLocation(latitude: 21.282778, longitude: -157.829444)
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.checkLocationAuthorizationStatus()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (CLLocationManager.locationServicesEnabled()) {
            self.locationManager = CLLocationManager()
            self.locationManager.delegate = self
            self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
            self.locationManager.requestAlwaysAuthorization()
            self.locationManager.startUpdatingLocation()
        }
        
//        self.centerMapOnLocation(initialLocation)
        
//        self.addStorePins()
    }
    
    func checkLocationAuthorizationStatus() {
        if (CLLocationManager.authorizationStatus() == .AuthorizedWhenInUse) {
            self.mapView.showsUserLocation = true
        } else {
            self.locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func addStorePins() {
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: 21.282778, longitude: -157.829444)
        annotation.title = "Magasin Test"
        annotation.subtitle = "test"
        self.mapView.addAnnotation(annotation)
    }
    
    @IBAction func onResetTouch(sender: AnyObject) {
        self.centerMapOnLocation(self.userLocation)
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations.last! as CLLocation
        self.userLocation = CLLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        self.mapView.setRegion(region, animated: true)
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let regionRadius: CLLocationDistance = 1000
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
            regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
}
