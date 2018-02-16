//
//  ZB-UrlBuilderHelper.swift
//  ZenBanana LLC
//
//  This is a function to help deal with all of the API calls made to the database. Use this file
//  to store and access the many api url extensions when making calls to the database.
//
//  Created by Jerry  Ramey on 10/25/16.
//  Copyright © 2016 ZenBanana. All rights reserved.
//

import Foundation

let APIBASEURL = "http://localhost:3000"

enum APIEndPoints {
    
    /// USER
    case User

}

let apiEPUrls = [
    
    /// USER
    APIEndPoints.User : "/users"

]


func urlEndPoint(apiEndPointKey: APIEndPoints) -> String {
    
    if let apiEndPoint = apiEPUrls[apiEndPointKey] {
        return APIBASEURL + apiEndPoint
    } else{
        return ""
    }
}

