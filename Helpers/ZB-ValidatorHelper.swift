//
//  ZB-ValidatorHelper.swift
//  ZenBanana LLC
//
//  This file is used to validate the basic attributes in an app.
//
//  Created by Tanner Juby on 1/11/17.
//  Copyright © 2017 ZenBanana LLP. All rights reserved.
//

import Foundation


// MARK: - CLASS NONSPECIFIC

/*
 Validates that a name string is at least 2 characters
 
 param: name - String
 
 returns: isValid - Bool
 
 Author: Tanner Juby
 */
func validName(_ name: String) -> Bool {
    log.verbose("Validating Name")
    
    if name.characters.count < 2 {
        return false
    } else {
        return true
    }
}

/*
 Validates URL Link string is a correct format. Used for Video and Banner Image
 
 param: UrlLink - String
 
 returns: isValid - Bool
 
 Author: Tanner Juby
 */
func validWebsiteUrl(_ url: String) -> Bool {
    log.verbose("Validating Url Link")
    
    let isValid = regexTest(input: url, forRegex: .WebsiteUrl)
    
    return isValid
}


/*
 Validates that the Video Url is a correct format.
 
 param: videoUrl - String
 
 returns: isValid - Bool
 
 Author: Tanner Juby
 */
func validVideoUrl(_ videoUrl: String) -> Bool {
    log.verbose("Validating Email")
    
    let isYoutubeValid = regexTest(input: videoUrl, forRegex: .YoutubeUrl)
    let isVinmeoValid = regexTest(input: videoUrl, forRegex: .VimeoUrl)
    
    var isValid = false
    
    if isYoutubeValid || isVinmeoValid {
        isValid = true
    }
    
    return isValid
    
}

// MARK: - USER SPECIFIC

/*
 Validates Email Url is a correct format.
 
 param: email - String
 
 returns: isValid - Bool
 
 Author: Tanner Juby
 */
func validUserEmail(_ email: String) -> Bool {
    log.verbose("Validating Email")
    
    let isValid = regexTest(input: email, forRegex: .Email)
    
    return isValid
    
}

/*
 Validates that a Password is a correct format.
 
 param: password - String
 
 returns: isValid - Bool
 
 Author: Tanner Juby
 */
func validPassword(_ password: String) -> Bool {
    log.verbose("Validating Password") 
    if password.characters.count < 6 {
        return false
    } else {
        return true
    }
}

/*
 Validates that a phone number is a correct format
 
 param: number - String
 
 returns: isValid - Bool
 
 Author: Tanner Juby
 */
func validPhoneNumber(_ number: String) -> Bool {
    log.verbose("Validating Phone Number")
    
    if regexTest(input: number, forRegex: .Phone) && number.characters.count == 10 {
        return true
    } else {
        return false
    }
    
}

