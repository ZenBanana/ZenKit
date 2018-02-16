//
//  ZB-UIViewExtension.swift
//  goodnessgroceries-ios
//
//  Created by Tanner Juby on 4/13/17.
//  Copyright © 2017 Juby. All rights reserved.
//

import Foundation
import UIKit

public extension UIView {
    
    /**
     MARK: - Functions on UIViews
     */
    
    /**
     Add Shadow
     
     Puts a Drop Shadow in the UIView
     */
    func addShadow(opacity: Float, yOffset: Int, xOffset: Int, radius: CGFloat) {
        
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = CGSize(width: xOffset, height: yOffset)
        self.layer.shadowRadius = radius
        
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
    }
    
    
    /**
     Round Corners
     
     Makes the corners rounded
     */
    func roundCorners(withRadius: CGFloat) {
        
        self.layer.cornerRadius = withRadius
        self.layer.masksToBounds = true
    }
    
    /**
     Make Circle
     
     Makes the view a circle
     */
    func makeCircle() {
        self.layer.cornerRadius = self.frame.size.width/2
        self.layer.masksToBounds = true
    }
    
    /**
     Set Underline Border
     
     Gives the view an underline border
    */
    func setUnderlineBorder(width: CGFloat) {
        let border = CALayer()
        border.borderColor = UIColor(red: 29.0 / 255.0, green: 29.0 / 255.0, blue: 38.0 / 255.0, alpha: 0.05).cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width, height: self.frame.size.height)
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
    
    
    /**
     MARK: - Loading From Nib Files
     */
    
    public class func fromNib(nibNameOrNil: String? = nil) -> Self {
        return fromNib(nibNameOrNil: nibNameOrNil, type: self)
    }
    
    public class func fromNib<T : UIView>(nibNameOrNil: String? = nil, type: T.Type) -> T {
        let v: T? = fromNib(nibNameOrNil: nibNameOrNil, type: T.self)
        return v!
    }
    
    public class func fromNib<T : UIView>(nibNameOrNil: String? = nil, type: T.Type) -> T? {
        var view: T?
        let name: String
        if let nibName = nibNameOrNil {
            name = nibName
        } else {
            // Most nibs are demangled by practice, if not, just declare string explicitly
            name = nibName
        }
        let nibViews = Bundle.main.loadNibNamed(name, owner: nil, options: nil)
        for v in nibViews! {
            if let tog = v as? T {
                view = tog
            }
        }
        return view
    }
    
    public class var nibName: String {
        let name = "\(self)".components(separatedBy: ".").first ?? ""
        return name
    }
    public class var nib: UINib? {
        if let _ = Bundle.main.path(forResource: nibName, ofType: "nib") {
            return UINib(nibName: nibName, bundle: nil)
        } else {
            return nil
        }
    }
}
