//
//  File.swift
//  Dibs
//
//  Created by Jacob Lattie on 3/31/20.
//  Copyright © 2020 Jacob Lattie. All rights reserved.
//

import Foundation
import MapKit

class DibsMapAnnotation: NSObject, MKAnnotation {
    
    let title: String?
    let locationName: String
    let spotCount: Int
    let coordinate: CLLocationCoordinate2D
    
    init(buildingNameTitle: String, locationName: String, spotCount: Int, coordinate: CLLocationCoordinate2D) {
        
        self.title = buildingNameTitle // required title field
        self.locationName = locationName
        self.spotCount = spotCount
        self.coordinate = coordinate
        
        super.init()
    }
    
    
    // compound required property of MKAnnotation
    var subtitle: String? {
      return locationName
    }
    
}
