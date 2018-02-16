//
//  ZB-UserLocationManager.swift
//  ZenBanana LLC
//
//  This class is to be used for applications that need to use loction in an efficiently. Instead of trying to set up the
//  location manager youself and trying to handle authorization, simply initiate an instance of this class in the User model
//  to be used with the currentUser of the application. This class makes it so that the applcation is not continually
//  using the CLLocationManager when it is not needed, instead, it turns off updating the location once it updates the
//  location upon request. To get a quick location update, simply call getQuickLocationUpdate() and then access the
//  last (variable) location.
//
//  Created by Tanner Juby on 11/28/16.
//  Copyright © 2016 ZenBanana. All rights reserved.
//

import Foundation
import CoreLocation
import XCGLogger

class UserLocationManager : NSObject, CLLocationManagerDelegate {
    
    // MARK: Variables
    var base = CLLocation(latitude: 39.7392, longitude: -104.9903)
    var last : CLLocation!
    
    var searchRange : Float = 25.0
    
    var locationManager = CLLocationManager()
    
    var isQuickUpdate = false
    
    // MARK: Initializers
    override init() {
        super.init()
        
        last = base
        
        locationManager.delegate = self
        
        // Request location authoriation
        self.locationManager.requestWhenInUseAuthorization()
        
        locationManager.delegate = self
    }
    
    // MARK: - Location Manager Functions
    
    /**
     Get a Quick Location Update
     */
    func getQuickLocationUpdate() {
        log.verbose("Updating the users current location")
        
        // This is not a quick update
        isQuickUpdate = true
        
        // Initialize the Location Manager Object
        locationManager = CLLocationManager()
        
        // Set the Delegate
        self.locationManager.delegate = self
        
        // Set the Accuracy
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        // Request location authoriation
        self.locationManager.requestWhenInUseAuthorization()
        
        // Request a location update
        self.locationManager.startUpdatingLocation()
    }
    
    /**
     Start Updating
     */
    func startUpdating() {
        log.verbose("Start Updating User Location")
        
        // This is not a quick update
        isQuickUpdate = false
        
        // Initialize the Location Manager Object
        locationManager = CLLocationManager()
        
        // Set the Delegate
        locationManager.delegate = self
        
        // Set the Accuracy
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        // Request location authoriation
        locationManager.requestWhenInUseAuthorization()
        
        // Request a location update
        locationManager.startUpdatingLocation()
    }
    
    /**
     Stop Updating
     */
    func stopUpdating() {
        log.verbose("Stop Updating User Location")
        
        locationManager.stopUpdatingLocation()
    }
    
    /**
     Update the Location Range
     */
    func updateRange(range: Float) {
        self.searchRange = range
    }
    
    /**
     Print the users current Location
     */
    func printLocation() {
        if (last != nil) {
            print("Current Location")
            print("Latitude: \(last?.coordinate.latitude ?? 39.7392), Longitude: \(last?.coordinate.longitude ?? 104.9903)")
        } else {
            print("Default Location")
            print("Latitude: \(base.coordinate.latitude), Longitude: \(base.coordinate.longitude)")
        }
    }
    
    // MARK: - Location Manager Delegate
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        last = manager.location!
        
        if isQuickUpdate {
            locationManager.stopUpdatingLocation()
            isQuickUpdate = false
        }
        
    }
    
}
