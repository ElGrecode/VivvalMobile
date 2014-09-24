//
//  ViewController.swift
//  Vivval
//
//  Created by Adam Schuld on 9/23/14.
//  Copyright (c) 2014 Design Gumption. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mv: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Base settings for our project to be GA's location
        var latitude:CLLocationDegrees  = 34.0121885
        var longitude:CLLocationDegrees = -118.4939107
        
        var latitudeOffset:CLLocationDegrees  = (34.0121885)
        var longitudeOffset:CLLocationDegrees = (-118.4939107 + 0.005)
        
        
        // Zoom settings
        var latDelta:CLLocationDegrees  = 0.01
        var lngDelta:CLLocationDegrees  = 0.01
        
        // Create coordinate wrappers
        var gaLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        var gaLocationOffset:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitudeOffset, longitudeOffset)
        var zoomSpan:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lngDelta)
        
        // Once we have all of the map information, we combine it into a region for display
        var theRegion:MKCoordinateRegion = MKCoordinateRegionMake(gaLocation, zoomSpan)
        
        // Link the map region to the view
        self.mv.setRegion(theRegion, animated: true)
        
        
        // Location Distance
        var locationDistance:CLLocationDistance = 100.0
        // Creating a pitch for a camera
        mv.pitchEnabled = true
        var mapCamera = MKMapCamera(lookingAtCenterCoordinate: gaLocation, fromEyeCoordinate: gaLocationOffset, eyeAltitude: locationDistance)
//        var mapCamera = mapCameraOC.copyWithZone(nil) as MKMapCamera
        mv.setCamera(mapCamera, animated: true)
        
        // Creating a pin
        var pinAnnotation = MKPointAnnotation()
        pinAnnotation.coordinate = gaLocation
        // Pin needs two pieces of information: title and subtitle
        pinAnnotation.title = "GA"
        pinAnnotation.subtitle = "Where we become cogs of the machine"
        
        self.mv.addAnnotation(pinAnnotation)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

