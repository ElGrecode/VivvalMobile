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
        var locationOffset:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitudeOffset, longitudeOffset)
        var zoomSpan:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lngDelta)
        
        // Once we have all of the map information, we combine it into a region for display
        var theRegion:MKCoordinateRegion = MKCoordinateRegionMake(gaLocation, zoomSpan)
        
        // Link the map region to the view
        self.mv.setRegion(theRegion, animated: true)
        
        // Map's Viewable Property Configuration
        mv.pitchEnabled = true
        mv.showsPointsOfInterest = false
        mv.zoomEnabled = true
        mv.showsBuildings = true
        
        // *** Camera Settings
        // Location Distance
        var locationDistance:CLLocationDistance = 5.0
        var mapCamera = MKMapCamera(lookingAtCenterCoordinate: gaLocation, fromEyeCoordinate: locationOffset, eyeAltitude: locationDistance)
        // Remove Points of Interest
        
        mv.setCamera(mapCamera, animated: true)
        
//        // Initial pin
//        var pinAnnotation = MKPointAnnotation()
//        pinAnnotation.coordinate = gaLocation
//        // Pin needs two pieces of information: title and subtitle
//        pinAnnotation.title = "GA"
//        pinAnnotation.subtitle = "Where we become cogs of the machine"
        
       // self.mv.addAnnotation(pinAnnotation)
        getMapData()
    }
    
    func getMapData() -> Void{
        // Mocking data for API call
        let apiKey = "jdfs8A3298Clkp62kH0uf29h29"
        let centralCoordinates = "34.0121885,-118.4939107"
        let zoomDelta = "3"
        let searchTerm = "shoes"
        
        let apiURL = NSURL(string: "http://vivval.jitsu.com/api/heatmap/\(apiKey)/\(centralCoordinates)/\(zoomDelta)/\(searchTerm)")
        //let forecastURL = NSURL(string: "34.026814,-118.501829", relativeToURL: baseURL) // unecessary for now
        
        let sharedSession = NSURLSession.sharedSession()
        let downloadTask: NSURLSessionDownloadTask = sharedSession.downloadTaskWithURL(apiURL, completionHandler: { (location: NSURL!, response: NSURLResponse!, error: NSError!) -> Void in
            if (error == nil){
                let dataObject = NSData(contentsOfURL: location)
                let blazonDictionary : NSDictionary = NSJSONSerialization.JSONObjectWithData(dataObject, options: nil, error: nil) as NSDictionary
                println(blazonDictionary)
                // Send the Blazon Dictonary to our own data model for cleanup
                let mapData = Location(blazonDictionary: blazonDictionary)
                
                // Let's see these values in console
                println("*** searchTerm:")
                println(mapData.searchTerm)
                println("*** blazons:")
                println(mapData.blazons)
                
                // dispatch_async is a function that submits a block of code to the dispatch queue managed by GCD
                // First parameter is what queue we are submitting to
                // Second parameter is a closure
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    // Get back to main queue to put in pins based on received mapData
                    println(mapData.blazons)
                    self.placePins(mapData.blazons!)
                })
                
            } else {
                let networkIssueController = UIAlertController(title: "Error", message: "Unable to Load Data. Connectivity Error!", preferredStyle: .Alert)
                
            }
            
        })
        downloadTask.resume()
    }

    //Our place pin function
    func placePins(mapData: [NSObject]){
        for blazon in mapData {
            var blazonLatitude:CLLocationDegrees  = blazon.valueForKey("blazonLat") as Double
            var blazonLongitude:CLLocationDegrees = blazon.valueForKey("blazonLng") as Double
            
            var pinLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(blazonLatitude, blazonLongitude)
        
            var pinAnnotation = MKPointAnnotation()
            pinAnnotation.coordinate = pinLocation
            // Pin needs two pieces of information: title and subtitle
            pinAnnotation.title = blazon.valueForKey("blazonName") as String
            pinAnnotation.subtitle = blazon.valueForKey("blazonText") as String
            
            
            self.mv.addAnnotation(pinAnnotation)
        }
    }

    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

