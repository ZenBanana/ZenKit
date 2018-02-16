//
//  ZB-RegexHelper.swift
//  ZenBanana LLC
//
//  This file tests to make sure a certain format depending on the regular expression
//
//  Created by Tanner Juby on 1/11/17.
//  Copyright (c) 2017 ZenBanana. All rights reserved.
//

import Foundation

//Regular Expression Class

enum RegularExpression {
    
    case Email
    
    case URL
    
    case WebsiteUrl
    case YoutubeUrl
    case VimeoUrl
    
    case Phone
}

let RegularExpressionPatterns = [
    
    RegularExpression.Email : "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}",
    RegularExpression.URL : "(http|https)://((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+",
    RegularExpression.WebsiteUrl : "/^(http|https):\\/\\/[a- z0-9]+([\\-\\.]{1}[a- z0-9]+)*\\.[a-z]{2,5}(:[0-9] {1,5})?(\\/.*)?$/ix",
    RegularExpression.YoutubeUrl : "((http|https)?://(www\\.)?(youtube\\.com|youtu\\.be)\\b.*?)",
    RegularExpression.VimeoUrl : "((http|https)?://(www)?\\.vimeo\\.com\\b.*?)",
    RegularExpression.Phone : "^[0-9]+$"
]

/*
 Test a Regular Expression
 
 param: input - String
 param: forRegex - RegularExpression
 
 returns: Bool
 
 author: Tanner Juby
*/
func regexTest(input: String, forRegex: RegularExpression) -> Bool {
    
    // Set Up Regex
    let pattern = RegularExpressionPatterns[forRegex]
    let regex = try! NSRegularExpression(pattern: pattern!, options: .caseInsensitive)
    
    // Test the Regex
    let matches = regex.matches(in: input, options: [], range: NSRange(location: 0, length: input.characters.count))
    
    // Return true or false
    return matches.count > 0
}
