//
//  Location.swift
//  Vivval
//
//  Created by Adam Schuld on 9/23/14.
//  Copyright (c) 2014 Design Gumption. All rights reserved.
//

import Foundation
import UIKit

struct Location {
//    var currentTime: String?
//    var temperature: Int
//    var humidity: Double
//    var precipProbability: Double
//    var summary: String
//    var icon: UIImage?
    var searchTerm:String
    var blazons:[NSObject]?
    
    
    init(blazonDictionary: NSDictionary){
        // some initialization here
        searchTerm = blazonDictionary["searchTerm"] as String
        blazons = groupBlazons(blazonDictionary["blazons"] as [NSObject])
//        let currentWeather = weatherDictionary["currently"] as NSDictionary
//        
//        let currentTimeIntValue = currentWeather["time"] as Int
//        let currentIconString = currentWeather["icon"] as String
//        
//        temperature = currentWeather["temperature"] as Int
//        humidity = currentWeather["humidity"] as Double
//        precipProbability = currentWeather["precipProbability"] as Double
//        summary = currentWeather["summary"] as String
//        
//        currentTime = dateStringFromUnixtime(currentTimeIntValue)
//        icon = weatherIconFromString(currentIconString)
        
    }
    
    func groupBlazons(groupBlazons:[NSObject]) -> [NSObject] {
        var blazonsArray:[NSObject] = []
        for blazon in groupBlazons{
            // See that it is working first
            var blazonText:AnyObject! = blazon.valueForKey("text")
            var blazonLat:AnyObject! = blazon.valueForKey("geolocation").valueForKey("lat")
            var blazonLng:AnyObject! = blazon.valueForKey("geolocation").valueForKey("lng")
            var blazonData:[String: AnyObject] = ["blazonText" : blazonText, "blazonLat" : blazonLat, "blazonLng" : blazonLng]
            
            blazonsArray.append(blazonData as NSObject)
            
        }
        return blazonsArray
    }
//    func dateStringFromUnixtime(unixTime: Int) -> String {
//        let timeInSeconds = NSTimeInterval(unixTime)
//        let weatherDate = NSDate(timeIntervalSince1970: timeInSeconds)
//        
//        let dateFormatter = NSDateFormatter()
//        dateFormatter.timeStyle = .ShortStyle
//        
//        return dateFormatter.stringFromDate(weatherDate)
//    }
//    
//    func weatherIconFromString(stringIcon: String) -> UIImage {
//        var imageName: String
//        
//        switch stringIcon {
//        case "clear-day":
//            imageName = "clear-day"
//        case "clear-night":
//            imageName = "clear-night"
//        case "snow":
//            imageName = "snow"
//        case "sleet":
//            imageName = "sleet"
//        case "wind":
//            imageName = "wind"
//        case "fog":
//            imageName = "fog"
//        case "cloudy":
//            imageName = "cloudy"
//        case "partly-cloudy":
//            imageName = "partly-cloudy"
//        case "partly-cloudy-night":
//            imageName = "cloudy-night"
//        default:
//            imageName = "default"
//        }
//        
//        var iconImage = UIImage(named: imageName)
//        return iconImage
    
}