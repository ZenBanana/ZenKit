//
//  DateExt.swift
//  ZenBanana LLC
//
//  Created by Jerry  Ramey on 9/23/15.
//  Copyright © 2017 ZenBanana. All rights reserved.
//

import Foundation


extension Date {
    
    func isGreaterThanDate(_ dateToCompare: Date) -> Bool {
        
        var isGreater = false
        
        if self.compare(dateToCompare) == ComparisonResult.orderedDescending {
            isGreater = true
        }
        
        return isGreater
    }
    
    func isLessThanDate(_ dateToCompare: Date) -> Bool {
        
        var isLess = false
        
        if self.compare(dateToCompare) == ComparisonResult.orderedAscending {
            isLess = true
        }
        
        return isLess
    }
    
}
