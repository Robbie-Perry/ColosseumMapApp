//
//  ViewController.swift
//  Map Challenge
//
//  Created by Robbie Perry on 2018-02-16.
//  Copyright © 2018 Robbie Perry. All rights reserved.
//

import UIKit
import MapKit
import TraceLog

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var label: UILabel!
    let regionRadius: CLLocationDistance = 20000
    let colosseumLocation = CLLocation(latitude: 41.8902, longitude: 12.4922)
    let colosseum: MapPoint = MapPoint(locationName: "Colosseum",
                                       latitude: 41.8902,
                                       longitude: 12.4922)
    var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
        logInfo { "Entering \(#function)" }
        super.viewDidLoad()
        
        centerMapOnLocation(location: colosseumLocation)
        placePoint(point: colosseum)
        
        if (CLLocationManager.locationServicesEnabled())
        {
            logInfo { "Location Services Enabled" }
            locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            logInfo { "Starting updating locations" }
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        logInfo { "Entering \(#function)" }
        if locations.count == 0 {
            return
        }
        
        let location = locations.last!
        logInfo { "\(location.coordinate.latitude)/\(location.coordinate.longitude)" }
        let myLocation: MapPoint = MapPoint(locationName: "Current Location",
                                            latitude: location.coordinate.latitude,
                                            longitude: location.coordinate.longitude)
        placePoint(point: myLocation)
        mapView.showAnnotations(self.mapView.annotations, animated: true)
        label.text = "Distance to colosseum: \(calculateDistanceToColosseum(location: location))"
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        logInfo { "Entering \(#function)" }
        logError { "Error: \(error.localizedDescription)"}
        logInfo { "Leaving \(#function)" }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        logInfo { "Entering \(#function)" }
        logInfo { "Status: \(status)"}
        logInfo { "Leaving \(#function)" }
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius, regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func placePoint(point: MapPoint)
    {
        logInfo { "Entering \(#function)" }
        mapView.addAnnotation(point)
    }
    
    func calculateDistanceToColosseum(location: CLLocation) -> Double
    {
        var distance: Double = colosseumLocation.distance(from: location) / 1000.0
        distance = Double(round(distance * 100)) / 100
        
        return distance
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

