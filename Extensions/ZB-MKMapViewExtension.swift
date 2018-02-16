//
//  ZB-MKMapViewExtension.swift
//  ZenBanana LLC
//
//  Created by Tanner Juby on 4/18/17.
//
//

import Foundation
import MapKit


extension MKMapView {

    /**
     Set Region For All Annotations
     
     Region will be centered on a central point amongst all annotations and will have a radius that encapsulates all annotations
     */
    func setRegionForAllAnnotations() {
        
        // Initialize the Main Map Rect
        var mainRect = MKMapRectNull
        
        // Iterates through each annotation allocated on the map.
        for a in self.annotations {
            
            let annotation = MKMapPointForCoordinate(a.coordinate)
            
            // Create a Map Rect out of the current annotation
            let annotationRect = MKMapRectMake(annotation.x, annotation.y, 0.0, 0.0)
            
            if MKMapRectIsNull(mainRect) {
                // Main Map Rect is not set, so set the first annotation Map Rect as the new Main Map Rect
                mainRect = annotationRect
            } else {
                // Main Map Rect is already set. Union together the Main Map Rect with the current annotation Map Rect to include the new annotation
                mainRect = MKMapRectUnion(mainRect, annotationRect)
            }
        }
        
        // Save the current origin points of the rect
        let centerX = MKMapRectGetMidX(mainRect)
        let centerY = MKMapRectGetMidY(mainRect)
        
        // Increase the size of the rect so the annotations aren't on the edge of the map
        mainRect.size.height = mainRect.size.height * 1.2
        mainRect.size.width = mainRect.size.width * 1.2
        
        // Change the origin points to be center on the grown Map Rect
        mainRect.origin.x = centerX - mainRect.size.width / 2
        mainRect.origin.y = centerY - mainRect.size.height / 2
        
        // Create a region out of the Map Rect with all the annotations in it.
        let region = MKCoordinateRegionForMapRect(mainRect)
        
        self.setRegion(region, animated: true)
        
    }
    
    /**
    Set Region For Location
 
    Region will be centered on a specific location given by params with a radius that is given by params
    */
    func setRegion(forCoordinate: CLLocationCoordinate2D, latitudeCenterOffsetRatio: Double, longitudeCenterOffsetRatio: Double) {
        
        var tempCoordinate = forCoordinate
        
        if latitudeCenterOffsetRatio < 0 {
            tempCoordinate.latitude -= self.region.span.latitudeDelta * latitudeCenterOffsetRatio
        } else {
            tempCoordinate.latitude += self.region.span.latitudeDelta * latitudeCenterOffsetRatio
        }
    
        if longitudeCenterOffsetRatio < 0 {
            tempCoordinate.longitude -= self.region.span.longitudeDelta * longitudeCenterOffsetRatio
        } else {
            tempCoordinate.longitude += self.region.span.longitudeDelta * longitudeCenterOffsetRatio
        }
        
        let coordinateRegion = MKCoordinateRegionMake(tempCoordinate, self.region.span)
        
        self.setRegion(coordinateRegion, animated: true)
        
    }
    
    /**
    Set Region for Location with Annotation
 
    Region will be centered on a specific location given by params with a radius determined by the furthest annotation away from the user
    */
    func setRegionWithAnnotations(forLocation: CLLocation) {
        
        var maxDistance : Double = 0
        
        for a in self.annotations {
            
            let tempLocation = CLLocation(latitude: a.coordinate.latitude, longitude: a.coordinate.longitude)
            let tempDistance = forLocation.distance(from: tempLocation)
            
            if tempDistance > maxDistance {
                maxDistance = tempDistance
            }
        }
        
        var tempCoordinate = forLocation.coordinate
        tempCoordinate.latitude -= self.region.span.latitudeDelta * 0.25
        
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(forLocation.coordinate,
                                                                  maxDistance * 1.1, maxDistance * 1.1)
        self.setRegion(coordinateRegion, animated: true)
        
    }
    
}
