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

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var storeListView: UIScrollView!
    @IBOutlet weak var inputText: UITextField!
    @IBOutlet weak var resetPositionBtn: UIButton!
    @IBOutlet weak var listButton: UIButton!
    
    var locationManager = CLLocationManager()
    var userLocation = CLLocation(latitude: 21.282778, longitude: -157.829444)
    
    override func viewWillAppear(animated: Bool) {
        self.storeListView.alpha = 0.0
        let nbStores = 5
        
        for (var i = 0; i < nbStores; i++) {
            let y = CGFloat((190 + 12) * i)
            self.storeListView.addSubview(StoreView(
                frame: CGRectMake(12, y, self.storeListView.frame.width - 24, 190),
                name: "Sephora Champs Elysées",
                adress: "89, avenue des Champs Elysées",
                city: "75002 Paris",
                hours: "Du lundi au vendredi : 10:00 - 20:00",
                distance: 123.0
            ))
        }
        
        self.storeListView.contentSize.width = self.storeListView.frame.width
        self.storeListView.contentSize.height = CGFloat(nbStores * (190 + 12))
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.checkLocationAuthorizationStatus()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mapView.delegate = self
        
        if (CLLocationManager.locationServicesEnabled()) {
            self.locationManager = CLLocationManager()
            self.locationManager.delegate = self
            self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
            self.locationManager.requestAlwaysAuthorization()
            self.locationManager.startUpdatingLocation()
        }
        
        self.addStorePins()
    }
    
    func checkLocationAuthorizationStatus() {
        if (CLLocationManager.authorizationStatus() == .AuthorizedWhenInUse) {
            self.mapView.showsUserLocation = true
        } else {
            self.locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func addStorePins() {
        let pointAnnotation = CustomPointAnnotation()
        pointAnnotation.coordinate = CLLocationCoordinate2DMake(48.864716, 2.349014)
        pointAnnotation.title = "Magasin test"
        pointAnnotation.subtitle = "Subtitle"
        pointAnnotation.imageName = "pin"
        
        self.mapView.addAnnotation(pointAnnotation)
    }
    
    @IBAction func onResetTouch(sender: AnyObject) {
        self.centerMapOnLocation(self.userLocation)
    }
    
    
    @IBAction func onListButtonTouch(sender: AnyObject) {
        self.mapView.alpha = 0.0
        self.resetPositionBtn.alpha = 0.0
        self.storeListView.alpha = 1.0
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
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if !(annotation is CustomPointAnnotation) {
            return nil
        }
        
        let reuseId = "test"
        
        var anView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId)
        if anView == nil {
            anView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            anView!.canShowCallout = true
        }
        else {
            anView!.annotation = annotation
        }
        
        //Set annotation-specific properties **AFTER**
        //the view is dequeued or created...
        
        let cpa = annotation as! CustomPointAnnotation
        anView!.image = UIImage(named:cpa.imageName)
        
        return anView
    }
}
