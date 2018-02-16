//
//  ZB-BottomSheetViewControllerExtension.swift
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
    func addBottomSheetView(_ bottomSheetVC: UIViewController) {
        
        // Add bottomSheet as a child VC
        self.addChildViewController(bottomSheetVC)
        self.view.addSubview(bottomSheetVC.view)
        bottomSheetVC.didMove(toParentViewController: self)
        
        // Adjust bottomSheet frame and initial position
        bottomSheetVC.view.frame = CGRect(x: 0, y: self.view.frame.maxY, width: view.frame.width, height: view.frame.height)
    }
    
    // MARK: - Gestures
    
    /**
     Bottom Sheet Close Pan Gesture
     
     The gesture for managing the closure of a bottom sheet view controller that is either completely open or hidden
    */
    func bottomSheetFullClosePanGesture(recognizer: UIPanGestureRecognizer) {
        
        let translation = recognizer.translation(in: self.view)
        var y = self.view.frame.minY
        
        if y < UIScreen.main.bounds.minY {
            y = UIScreen.main.bounds.minY
        } else if y > UIScreen.main.bounds.maxY {
            y = UIScreen.main.bounds.maxY
        }
        
        self.view.frame = CGRect(x: 0, y: y + translation.y, width: view.frame.width, height: view.frame.height)
        recognizer.setTranslation(CGPoint.zero, in: self.view)
        
        if recognizer.state == UIGestureRecognizerState.ended {
            
            if recognizer.velocity(in: self.view).y > 2000 {
                // Swiped Down Fast to close
                
                UIView.animate(withDuration: 0.3, animations: {
                    self.view.frame = CGRect(x: 0, y: UIScreen.main.bounds.maxY, width: self.view.frame.width, height: self.view.frame.height)
                }, completion: { (true) in
                    self.view.removeFromSuperview()
                })
                
                
            } else if recognizer.velocity(in: self.view).y < -2000 {
                // Swiped Up Fast to keep open
                
                UIView.animate(withDuration: 0.3, animations: {
                    self.view.frame = CGRect(x: 0, y: UIScreen.main.bounds.maxY * 0.05, width: self.view.frame.width, height: self.view.frame.height)
                })
                
            } else if self.view.frame.minY < (UIScreen.main.bounds.maxY / 2) {
                // Stopped swipe determine position
                
                UIView.animate(withDuration: 0.3, animations: {
                    self.view.frame = CGRect(x: 0, y: UIScreen.main.bounds.maxY * 0.05, width: self.view.frame.width, height: self.view.frame.height)
                })
                
            } else {
                
                UIView.animate(withDuration: 0.3, animations: {
                    self.view.frame = CGRect(x: 0, y: UIScreen.main.bounds.maxY, width: self.view.frame.width, height: self.view.frame.height)
                }, completion: { (true) in
                    self.view.removeFromSuperview()
                })
            }
        }
        
    }
    
//    func tableCellPanGestureAction(recognizer: UIPanGestureRecognizer) {
//        
//        guard let view: UIView = recognizer.view else {
//            return
//        }
//        
//        let translation = recognizer.translation(in: view)
//        
//        let minX = view.frame.minX
//        
//        let actionWidth = view.frame.height * 0.75
//        let triggerPoint = view.frame.height * 0.375
//        
//        let minXForLeftAction = actionWidth
//        let minXForRightAction = -actionWidth
//        
//        view.frame = CGRect(x: minX + translation.x, y: 0, width: view.frame.width, height: view.frame.height)
//        recognizer.setTranslation(CGPoint.zero, in: view)
//        
//        if recognizer.state == UIGestureRecognizerState.ended {
//            // Determine Current State
//            
//            if view.frame.minX > triggerPoint {
//                // Open Left Action
//                UIView.animate(withDuration: 0.3, animations: {
//                    view.frame = CGRect(x: minXForLeftAction, y: 0, width: view.frame.width, height: view.frame.height)
//                })
//                
//            } else if view.frame.minX < -triggerPoint {
//                // Open Right Action
//                UIView.animate(withDuration: 0.3, animations: {
//                    view.frame = CGRect(x: minXForRightAction, y: 0, width: view.frame.width, height: view.frame.height)
//                })
//                
//            } else {
//                // Set to original position
//                UIView.animate(withDuration: 0.3, animations: {
//                    view.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
//                })
//            }
//        }
//    }
}
