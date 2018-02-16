//
//  MapPoint.swift
//  Map Challenge
//
//  Created by Robbie Perry on 2018-02-16.
//  Copyright © 2018 Robbie Perry. All rights reserved.
//

import Foundation
import MapKit

class MapPoint: NSObject, MKAnnotation {
    let locationName: String
    let coordinate: CLLocationCoordinate2D
    
    init(locationName: String, latitude: Double, longitude: Double) {
        self.locationName = locationName
        self.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        super.init()
    }
    
    var subtitle: String? {
        return locationName
    }
}
