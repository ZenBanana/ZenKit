//
//  ZB-UIButtonExtension.swift
//  goodnessgroceries-ios
//
//  Created by Tanner Juby on 4/13/17.
//  Copyright © 2017 Juby. All rights reserved.
//

import Foundation
import UIKit

public extension UIButton {
    
    /**
    Disable
 
    Disables the button temporarily 
    */
    func disable() {
        self.alpha = 0.5
        self.isUserInteractionEnabled = false
    }
    
    /**
    Enable
 
    Enables the button 
    */
    func enable() {
        self.alpha = 1
        self.isUserInteractionEnabled = true
    }
}
