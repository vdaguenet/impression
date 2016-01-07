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
    @IBOutlet weak var ssss: CustomTextField! // sorry for the name but after 3h around a bug, only this name worked
    @IBOutlet weak var resetPositionBtn: UIButton!
    @IBOutlet weak var listButton: UIButton!
    
    var locationManager = CLLocationManager()
    var userLocation = CLLocation(latitude: 21.282778, longitude: -157.829444)
    var listVisible = false
    let storeModel = StoreModel()
    
    @IBAction func backFromChooseLoginView(segue: UIStoryboardSegue) {}
    
    override func viewWillAppear(animated: Bool) {
        if (self.listVisible == false) {
//            self.storeListView.alpha = 0.0
            self.storeListView.center.y += self.storeListView.frame.height
        }
        

        self.ssss.addSearchIcon()
        
        var i = 0
        var nbStores = 0
        for store in self.storeModel.findAll() {
            let y = CGFloat((190 + 12) * i)
            let name = store.get(self.storeModel.expressions.name)
            let adress = store.get(self.storeModel.expressions.adress)
            
            self.storeListView.addSubview(StoreView(
                frame: CGRectMake(12, y, self.storeListView.frame.width - 24, 190),
                name: name,
                adress: adress,
                city: store.get(self.storeModel.expressions.city),
                hours: store.get(self.storeModel.expressions.hours),
                distance: Float32((Double(arc4random()) / 0x100000000) * (1000.0 - 10.0) + 10.0),
                parentController: self
            ))
            
            self.addStorePin(name, baseline: adress, coord: CLLocationCoordinate2DMake(store.get(self.storeModel.expressions.lat), store.get(self.storeModel.expressions.long)))
            
            i += 1
            nbStores += 1
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
    }
    
    func checkLocationAuthorizationStatus() {
        if (CLLocationManager.authorizationStatus() == .AuthorizedWhenInUse) {
            self.mapView.showsUserLocation = true
        } else {
            self.locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func addStorePin(name: String, baseline: String, coord: CLLocationCoordinate2D) {
        let pointAnnotation = CustomPointAnnotation()
        pointAnnotation.coordinate = coord
        pointAnnotation.title = name
        pointAnnotation.subtitle = baseline
        pointAnnotation.imageName = "pin"
        
        self.mapView.addAnnotation(pointAnnotation)
    }
    
    @IBAction func onResetTouch(sender: AnyObject) {
        self.centerMapOnLocation(self.userLocation)
    }
    
    
    @IBAction func onListButtonTouch(sender: AnyObject) {
        if (self.listVisible == true) {
            UIView.animateWithDuration(0.5, delay: 0.0, options: [ .CurveEaseInOut ], animations: {
                self.mapView.alpha = 1.0
                self.resetPositionBtn.alpha = 1.0
                self.storeListView.center.y += self.storeListView.frame.height
                self.listButton.setImage(UIImage(named: "list"), forState: UIControlState.Normal)
                }, completion: { (finished: Bool) -> Void in
                    self.listVisible = false
                })
        } else {
            
            UIView.animateWithDuration(0.5, delay: 0.0, options: [ .CurveEaseInOut ], animations: {
                    self.mapView.alpha = 0.0
                    self.storeListView.center.y -= self.storeListView.frame.height
                    self.listButton.setImage(UIImage(named: "back-map"), forState: UIControlState.Normal)
                }, completion: { (finished: Bool) -> Void in
                    self.resetPositionBtn.alpha = 0.0
                    self.listVisible = true
                })
        }
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
