//
//  ZB-MapSheetViewControllerExtension.swift
//  goodnessgroceries-ios
//
//  Created by Tanner Juby on 4/13/17.
//  Copyright © 2017 Juby. All rights reserved.
//

import Foundation
import UIKit

public extension UIViewController {
    
    // MARK: - Initiation
    
    /**
     Add Bottom Sheet View
     
     Adds a bottom sheet view to the current view
     */
    func addMapSheetView(_ bottomSheetVC: UIViewController) {
        
        // Add bottomSheet as a child VC
        self.addChildViewController(bottomSheetVC)
        self.view.addSubview(bottomSheetVC.view)
        bottomSheetVC.didMove(toParentViewController: self)
        
        // Adjust bottomSheet frame and initial position
        bottomSheetVC.view.frame = CGRect(x: 0, y: UIScreen.main.bounds.height, width: view.frame.width, height: view.frame.height)
        
    }
    
    // MARK: - Gestures
    
    /**
     Map Table View Movement Pan Gesture
     
     The gesture for managing a table view for the map. Is restricted between moving between two points
    */
    func mapTableViewMovementPanGesture(recognizer: UIPanGestureRecognizer) {
        
        let translation = recognizer.translation(in: self.view)
        var y = self.view.frame.minY
        
        // Limit users ability to move MapSheet
        if y < UIScreen.main.bounds.midY {
            y = UIScreen.main.bounds.midY
        } else if y > (UIScreen.main.bounds.maxY * 0.9) {
            y = UIScreen.main.bounds.maxY * 0.9
        }

        
        self.view.frame = CGRect(x: 0, y: y + translation.y, width: view.frame.width, height: view.frame.height)
        recognizer.setTranslation(CGPoint.zero, in: self.view)
        
        if recognizer.state == UIGestureRecognizerState.ended {
            
            if recognizer.velocity(in: self.view).y > 2000 {
                // Swiped Down Fast put to initial position
                
                UIView.animate(withDuration: 0.3, animations: {
                    self.view.frame = CGRect(x: 0, y: UIScreen.main.bounds.maxY * 0.9, width: self.view.frame.width, height: self.view.frame.height)
                })
                
                
            } else if recognizer.velocity(in: self.view).y < -2000 {
                // Swiped Up Fast to open
                
                UIView.animate(withDuration: 0.3, animations: {
                    self.view.frame = CGRect(x: 0, y: UIScreen.main.bounds.maxY * 0.5, width: self.view.frame.width, height: self.view.frame.height)
                })
                
            } else if self.view.frame.minY < (UIScreen.main.bounds.maxY * 0.7) {
                // Stopped swipe determine position
                
                UIView.animate(withDuration: 0.3, animations: {
                    self.view.frame = CGRect(x: 0, y: UIScreen.main.bounds.maxY * 0.5, width: self.view.frame.width, height: self.view.frame.height)
                })
                
            } else {
                
                UIView.animate(withDuration: 0.3, animations: {
                    self.view.frame = CGRect(x: 0, y: UIScreen.main.bounds.height * 0.9, width: self.view.frame.width, height: self.view.frame.height)
                })
            }
        }
        
    }
    
    /**
     Map Object Information Close Pan Gesture
     
     The gesture for managing a map objects information. Can either be open or is closed
     */
    func mapObjectInformationClosePanGesture(recognizer: UIPanGestureRecognizer) {
        
        let translation = recognizer.translation(in: self.view)
        var y = self.view.frame.minY
        
        // Limit users ability to move MapSheet
        if y < UIScreen.main.bounds.midY {
            y = UIScreen.main.bounds.midY
        } else if y > (UIScreen.main.bounds.maxY) {
            y = UIScreen.main.bounds.maxY
        }
        
        self.view.frame = CGRect(x: 0, y: y + translation.y, width: view.frame.width, height: view.frame.height)
        recognizer.setTranslation(CGPoint.zero, in: self.view)
        
        if recognizer.state == UIGestureRecognizerState.ended {
            
            if recognizer.velocity(in: self.view).y > 2000 {
                // Swiped Down Fast, close it
                
                UIView.animate(withDuration: 0.3, animations: {
                    self.view.frame = CGRect(x: 0, y: UIScreen.main.bounds.maxY, width: self.view.frame.width, height: self.view.frame.height)
                }, completion: { _ in
                    self.view.removeFromSuperview()
                })
                
                
            } else if recognizer.velocity(in: self.view).y < -2000 {
                // Swiped Up Fast to keep open
                
                UIView.animate(withDuration: 0.3, animations: {
                    self.view.frame = CGRect(x: 0, y: UIScreen.main.bounds.maxY * 0.5, width: self.view.frame.width, height: self.view.frame.height)
                })
                
            } else if self.view.frame.minY < (UIScreen.main.bounds.maxY * 0.75) {
                // Stopped swipe determine position
                
                UIView.animate(withDuration: 0.3, animations: {
                    self.view.frame = CGRect(x: 0, y: UIScreen.main.bounds.maxY * 0.5, width: self.view.frame.width, height: self.view.frame.height)
                })
                
            } else {
                
                UIView.animate(withDuration: 0.3, animations: {
                    self.view.frame = CGRect(x: 0, y: UIScreen.main.bounds.maxY, width: self.view.frame.width, height: self.view.frame.height)
                }, completion: { _ in
                    self.view.removeFromSuperview()
                })
            }
        }
        
    }
    
    
}
