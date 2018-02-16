//
//  ZB-ImageExtension.swift
//  ZenBanana LLC
//
//  Provides extension functions for UIImage.
//
//  Created by Tanner Juby on 3/7/17.
//  Copyright © 2017 ZenBanana LLP. All rights reserved.
//

import Foundation
import UIKit


extension UIImage {
    
    /**
     Resized UIImage
     
     Resizes an image to width and height passed in through params
     
     Author: Tanner Juby
    */
    func resizedImage(width: CGFloat, height: CGFloat) -> UIImage {
        
        UIGraphicsBeginImageContext(CGSize(width: width, height: height))
        self.draw(in: CGRect(x: 0, y: 0, width: width, height: height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    
}
